//
//  NSObject+Binding.m
//  CoreMeta
//
//  Created by Joshua Gretz on 5/23/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "NSObject+Binding.h"
#import "Binder.h"

@implementation NSObject (Binding)

-(void) bindForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath {
    [[Binder sharedBinder] bind: self keypath: selfKeyPath to: object keypath: objectKeyPath];
}

-(void) bindForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath withManipulation: (id (^)(id)) manipulation {
    [[Binder sharedBinder] bind: self keypath: selfKeyPath to: object keypath: objectKeyPath withManipulation: manipulation];
}

-(void) unbindForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath; {
    [[Binder sharedBinder] unbind: self keypath: selfKeyPath to: object keypath: objectKeyPath];
}

-(void) bindBothForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath {
    [[Binder sharedBinder] bindBoth: self keypath: selfKeyPath to: object keypath: objectKeyPath];
}

-(void) bindBothForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath withManipulation: (id (^)(id)) manipulation {
    [[Binder sharedBinder] bindBoth: self keypath: selfKeyPath to: object keypath: objectKeyPath withManipulation: manipulation];
}

-(void) unbindBothForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath {
    [[Binder sharedBinder] unbindBoth: self keypath: selfKeyPath to: object keypath: objectKeyPath];
}

@end
