//
//  Mixin.m
//  CoreMeta
//
//  Created by Joshua Gretz on 3/9/12.
//
/* Copyright 2011 TrueFit Solutions
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


#import "Mixin.h"
#import "NSObject+IOC.h"
#import <objc/runtime.h>


#pragma mark - Class Mapping Logic
@interface ClassMethodsMap : NSObject
@property (retain) Class class;
@property (assign) Method* methodsForClass;
@property (assign) int methodsCount;
@property (assign) Method* classMethodsForClass;
@property (assign) int classMethodsCount;
@end

@implementation ClassMethodsMap
@synthesize class, methodsForClass, methodsCount, classMethodsCount, classMethodsForClass;
@end

@implementation Mixin

+(NSMutableDictionary*) classMap {
    static NSMutableDictionary* classMapInstance;
    
    @synchronized(self) {
        if (!classMapInstance)
            classMapInstance = [[NSMutableDictionary alloc] init];
        
        return classMapInstance;
    }
}

+(ClassMethodsMap*) methodsForClass: (Class) class {
    ClassMethodsMap* map = [[Mixin classMap] objectForKey: NSStringFromClass(class)];
    if (!map) {
        map = [ClassMethodsMap object];
        map.class = class;
        
        unsigned int methodsCount = 0;
        map.methodsForClass = class_copyMethodList(class, &methodsCount);
        map.methodsCount = methodsCount;
        
        map.classMethodsForClass = class_copyMethodList(object_getClass(class), &methodsCount);
        map.classMethodsCount = methodsCount;
        
        [[Mixin classMap] setObject: map forKey: NSStringFromClass(class)];
    }
    
    return map;
}

#pragma mark -Mixin Logic
+(void) mixClass: (Class) source into: (Class) target {
    [Mixin mixClass: source into: target inherit: YES replaceExistingMethods: YES];
}

+(void) mixClass: (Class) source into: (Class) target inherit: (BOOL) inherit replaceExistingMethods: (BOOL) replaceExisting {
	ClassMethodsMap* sourceMap = [Mixin methodsForClass: source];
    
    void(^replaceMethod)(Method, Class, BOOL) = ^(Method method, Class into, BOOL classMethod) {
        SEL sourceName = method_getName(method);

        // be sure to climb up the inheritance tree for the target
        Class test = into;
        while (test && test != [NSObject class]) {
            ClassMethodsMap* targetMap = [Mixin methodsForClass: test];
            
            int count = classMethod ? targetMap.classMethodsCount : targetMap.methodsCount;
            Method* methods = classMethod ? targetMap.classMethodsForClass : targetMap.methodsForClass;
            
            for (int i = 0; i < count; i++) {
                SEL targetName = method_getName(methods[i]);
                if (sel_isEqual(sourceName, targetName) && !replaceExisting)
                    return;
            }
            
            test = [test superclass];
        }
        
        class_replaceMethod(into, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
    };
    
    // copy over the instance methods
	for (int i = 0; i < sourceMap.methodsCount; i++)
        replaceMethod(sourceMap.methodsForClass[i], target, NO);
    
    // copy over the class methods    
	for (int i = 0; i < sourceMap.classMethodsCount; i++)
        replaceMethod(sourceMap.classMethodsForClass[i], object_getClass(target), YES);
    
    if (inherit) {
        Class sourceSuper = class_getSuperclass(source);
        if (sourceSuper) {
            // dont add from the same tree > eventually we are gonna get to NSObject
            Class targetSuper = class_getSuperclass(target);
            while (targetSuper) {
                if (targetSuper == sourceSuper)
                    return;
                targetSuper = class_getSuperclass(targetSuper);
            }
            
            [Mixin mixClass: sourceSuper into: target inherit: inherit replaceExistingMethods: replaceExisting];
        }
    }
}

@end

@implementation NSObject (Mixin)

-(void) mixinClass: (Class)source {
    [Mixin mixClass: source into: [self class]];
}

-(void) mixinClass:(Class)source inherit: (BOOL) inherit replaceExistingMethods: (BOOL) replaceExisting {
    [Mixin mixClass: source into: [self class] inherit: inherit replaceExistingMethods: replaceExisting];
}

@end