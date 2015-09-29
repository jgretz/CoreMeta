//
//  NSObject+IOC.h
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

#import <Foundation/Foundation.h>

@interface NSObject (IOC)

#pragma mark - Object Initializers
+(id) object;
+(id) objectWith: (NSDictionary*) propertyValues;
+(id) objectUsingInitSelector: (SEL) selector withArguments: (NSArray*) args;
+(id) objectOnCreate:(void(^)(id)) onCreate;

#pragma mark - Injection / Cache Control
-(void) inject;
-(void) put;
-(void) putForClass: (Class) classType;
-(void) removeFromIOC;

#pragma mark - Registration Shortcuts
+(void) registerClass;
+(void) registerClassAndCache: (BOOL) cache;
+(void) registerClassAndCache: (BOOL) cache onCreate: (void(^)(id)) onCreate;
+(void) registerClassForClass: (Class) overrideClass;
+(void) registerClassForClass: (Class) overrideClass cache: (BOOL) cache;
+(void) registerClassForProtocol: (Protocol*) protocol;
+(void) registerClassForProtocoal: (Protocol*) protocol cache: (BOOL) cache;

@end
