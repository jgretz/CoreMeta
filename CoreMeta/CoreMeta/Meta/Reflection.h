//
//  ClassInfo.h
//  CoreMeta
//
//  Created by Joshua Gretz on 3/12/12.
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
#import "PropertyInfo.h"

@interface Reflection : NSObject

+(void) addGlobalClassToIgnore: (Class) type;
+(void) addGlobalPropertyToIgnore: (NSString*) propertyName;

+(Class) superClass: (Class) classType;

+(NSArray*) instanceVariablesForClass: (Class) classType;
+(NSArray*) instanceVariablesForClass: (Class) classType includeInheritance: (BOOL) includeInheritance;

+(NSArray*) propertiesForClass: (Class) classType;
+(NSArray*) propertiesForClass: (Class) classType includeInheritance: (BOOL) includeInheritance;
+(NSArray*) protocolsForClass: (Class) classType;

+(PropertyInfo*) infoForProperty: (NSString*) propertyName onClass: (Class) classType;
+(BOOL) continueUpTree: (Class) classType;

+(NSArray*) classesThatConformToProtocol: (Protocol*) protocol;

@end