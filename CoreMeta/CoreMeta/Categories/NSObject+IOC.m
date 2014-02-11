//
//  NSObject+IOC.m
//  CoreMeta
//
//  Created by Joshua Gretz on 3/21/12.
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

#import "NSObject+IOC.h"
#import "Container.h"

@implementation NSObject (IOC)

#pragma mark - Object Initializers
+(instancetype) object {
    return [[Container sharedContainer] objectForClass: [self class]];
}

+(instancetype) objectWith: (NSDictionary*) propertyValues {
    return [[Container sharedContainer] objectForClass: [self class] withPropertyValues: propertyValues];
}

+(instancetype) objectUsingInitSelector: (SEL) selector withArguments: (NSArray*) args {
    return [[Container sharedContainer] objectForClass: [self class] usingInitSelector: selector withArguments: args];
}

+(instancetype) objectOnCreate:(void(^)(id)) onCreate {
	id obj = [[Container sharedContainer] objectForClass: [self class]];

	if (onCreate)
		onCreate(obj);
	
	return obj;
}

#pragma mark - Injection / Cache Control
-(void) inject {
    [[Container sharedContainer] inject: self];
}

-(void) put {
    [[Container sharedContainer] put: self];
}

-(void) putForClass: (Class) classType {
    [[Container sharedContainer] put: self forClass: classType];
}

-(void) removeFromIOC {
    [[Container sharedContainer] put: nil forClass: [self class]];
}

#pragma mark - Registration Shortcuts
+(void) registerClass {
    [[Container sharedContainer] registerClass: [self class]];
}

+(void) registerClassAndCache: (BOOL) cache {
    [[Container sharedContainer] registerClass: [self class] cache: YES];
}

+(void) registerClassAndCache: (BOOL) cache onCreate: (void (^)(id)) onCreate {
    [[Container sharedContainer] registerClass: [self class] cache: YES onCreate: onCreate];
}

+(void) registerClassForClass: (Class) overrideClass {
    [[Container sharedContainer] registerClass: [self class] forClass: overrideClass];
}

+(void) registerClassForClass: (Class) overrideClass cache: (BOOL) cache {
    [[Container sharedContainer] registerClass: [self class] forClass: overrideClass cache: cache];
}

+(void) registerClassForProtocol: (Protocol*) protocol {
    [[Container sharedContainer] registerClass: [self class] forProtocol: protocol];
}

+(void) registerClassForProtocoal: (Protocol*) protocol cache: (BOOL) cache {
    [[Container sharedContainer] registerClass: [self class] forProtocol: protocol cache: cache];
}

@end
