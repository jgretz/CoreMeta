//
//  ObjectMapper.h
//  CoreMeta
//
//  Created by Joshua Gretz on 4/12/12.
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
#import "ObjectMap.h"

@interface ObjectMapper : NSObject

+(void) map: (id) source into: (id) target;
+(void) map: (id) source into: (id) target withMap: (ObjectMap*) map;
+(void) map: (id) source into: (id) target withMapOfType: (Class) classType;

+(id) create: (Class) classType from: (id) source;
+(id) create: (Class) classType from: (id) source withMap: (ObjectMap*) map;
+(id) create: (Class) classType from: (id) source withMapOfType: (Class) mapClassType;

+(void) registerMap: (Class) objectMap forClass: (Class) source toClass: (Class) target;

@end
