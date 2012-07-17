//
//  Binder.m
//  core
//
//  Created by Joshua Gretz on 5/23/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "Binder.h"
#import <objc/runtime.h>
#import "NSObject+IOC.h"
#import "NSArray+Helpers.h"
#import "NSString+Helpers.h"

#pragma mark NSObject Category
@interface NSObject(BinderPrivate)
@property (copy) NSString* binderId;
@end

@implementation NSObject(BinderPrivate)

const NSString* BINDER_ID = @"BinderId";

-(NSString*) binderId {
    return objc_getAssociatedObject(self, &BINDER_ID);
}

-(void) setBinderId:(NSString *)binderId {
    objc_setAssociatedObject(self, &BINDER_ID, binderId, OBJC_ASSOCIATION_COPY);
}

@end

#pragma mark Helper Class
@interface Binding : NSObject
@property (retain) NSObject* observer;
@property (copy) NSString* observerKeypath;
@property (copy) NSString* targetKeypath;
@property (assign) BOOL inUse;
@property (copy) id(^manipulation)(id);
@end

@implementation Binding
@synthesize observer, observerKeypath, targetKeypath, inUse, manipulation;
@end

#pragma mark Binder
@implementation Binder {
    NSMutableDictionary* bindings;
}

#pragma mark - Shared Singleton
+(Binder*) sharedBinder {
    static Binder* sharedBinderInstance;
    
    @synchronized(self) {
        if (!sharedBinderInstance)
            sharedBinderInstance = [Binder object];
        
        return sharedBinderInstance;
    }
}

#pragma mark Init
-(id) init {
    if ((self = [super init])) {
        bindings = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark Bind Logic
-(void) bind: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath {
    [self bind: object1 keypath: object1_keypath to: object2 keypath: object2_keypath withManipulation: nil];
}

-(void) bind: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath withManipulation: (id (^)(id)) manipulation {
    [self assignBinderId: object1];
    [self assignBinderId: object2];
        
    @synchronized(bindings) {
        NSMutableArray* bindingsForKeypath = [self bindingsForKeyPath: object2_keypath onObject: object2];
        if (!bindingsForKeypath) {
            bindingsForKeypath = [NSMutableArray array];
            [bindings setObject: bindingsForKeypath forKey: [self bindingIdForKeyPath: object2_keypath onObject: object2]];
        }
        
        Binding* binding = [bindingsForKeypath firstWhereBlock:^BOOL(Binding* binding, NSDictionary *bindings) {
            return [binding.observer isEqual: object1] && [binding.observerKeypath isEqual: object1_keypath];
        }];
        
        // duplicate
        if (binding)
            return;
        
        binding = [Binding object];
        binding.observer = object1;
        binding.observerKeypath = object1_keypath;
        binding.targetKeypath = object2_keypath;
        binding.manipulation = manipulation;
        [bindingsForKeypath addObject: binding];
        
        [object2 addObserver: self forKeyPath: object2_keypath options: NSKeyValueObservingOptionNew context: nil];
        
        // fire off initial value
        [self fireBinding: binding withValue: [object2 valueForKeyPath: object2_keypath]];
    }
}

-(void) unbind: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath {
    NSMutableArray* bindingsForKeypath = [self bindingsForKeyPath: object2_keypath onObject: object2];
    if (!bindingsForKeypath)
        return;
    
    Binding* binding = [bindingsForKeypath firstWhereBlock:^BOOL(Binding* binding, NSDictionary *bindings) {
        return [binding.observer isEqual: object1] && [binding.observerKeypath isEqual: object1_keypath];
    }];
    
    if (binding) {
        @synchronized(bindings) {
            [bindingsForKeypath removeObject: binding];
            
            if (bindingsForKeypath.count == 0) {
                [bindings removeObjectForKey: [self bindingIdForKeyPath: object2_keypath onObject: object2]];
                [object2 removeObserver: self forKeyPath: object2_keypath];
            }
        }
    }
}

-(void) bindBoth: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath {
    [self bindBoth: object1 keypath: object1_keypath to: object2 keypath: object2_keypath withManipulation: nil];
}

-(void) bindBoth: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath withManipulation: (id (^)(id)) manipulation {
    id value = [object1 valueForKeyPath: object1_keypath];
    if (manipulation)
        value = manipulation(value);    
    [object2 setValue: value forKey: object2_keypath]; // sync
    
    [self bind: object1 keypath: object1_keypath to: object2 keypath: object2_keypath withManipulation: manipulation];
    [self bind: object2 keypath: object2_keypath to: object1 keypath: object1_keypath withManipulation: manipulation];
}

-(void) unbindBoth: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath {
    [self unbind: object1 keypath: object1_keypath to: object2 keypath: object2_keypath];
    [self unbind: object2 keypath: object2_keypath to: object1 keypath: object1_keypath];
}

#pragma mark Internal Logic
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(NSObject*)object change:(NSDictionary *)change context:(void *)context {
    @synchronized(bindings) {
        NSArray* bindingsForKeypath = [self bindingsForKeyPath: keyPath onObject: object];
        for (Binding* binding in bindingsForKeypath)
            [self fireBinding: binding withValue: [change objectForKey: NSKeyValueChangeNewKey]];
    }
}

-(void) fireBinding: (Binding*) binding withValue: (id) value {
    if (binding.inUse)
        return;
        
    binding.inUse = YES;
    
    if (binding.manipulation)
        value = binding.manipulation(value);
    
    [binding.observer setValue: value forKey: binding.observerKeypath];            
    
    binding.inUse = NO;
}

-(void) assignBinderId: (NSObject*) object {
    if (object.binderId)
        return;
    
    object.binderId = [NSString newStringWithUUID];
}

-(NSString*) bindingIdForKeyPath: (NSString*) keypath onObject: (NSObject*) object {
    return [NSString stringWithFormat: @"%@_%@", object.binderId, keypath];
}

-(NSMutableArray*) bindingsForKeyPath: (NSString*) keypath onObject: (NSObject*) object {
    return [bindings objectForKey: [self bindingIdForKeyPath: keypath onObject: object]];
}

@end
