//
//  NSObject+KVO.h
//  CoreMeta
//
//  Created by Joshua Gretz on 4/17/12.
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

#define OBJECT_KEYPATH(object, property) ((void)(NO && ((void)object.property, NO)), @#property)
#define SELF_KEYPATH(property) OBJECT_KEYPATH(self, property)
#define CLASS_KEYPATH(class, property) OBJECT_KEYPATH([class new], property)

@interface NSObject (KVO)

-(void) when: (NSString*) keyPath changes: (void (^)()) block;
-(void) when: (NSString*) keyPath becomes: (BOOL (^)()) testBlock do: (void (^)()) block;

-(void) when: (NSString*) keyPath changesExecute: (void (^)(id, NSDictionary*)) block;
-(void) when: (NSString*) keyPath becomes: (BOOL (^)(id, NSDictionary*)) testBlock execute: (void (^)(id, NSDictionary *))block;

-(void) clearKVO;
-(void) clearKVOForPath: (NSString*) keyPath;

@end
