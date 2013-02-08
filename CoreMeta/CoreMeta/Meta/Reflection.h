//
//  ClassInfo.h
//  core
//
//  Created by Joshua Gretz on 3/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyInfo.h"

@interface Reflection : NSObject

+(Class) superClass: (Class) classType;

+(NSArray*) instanceVariablesForClass: (Class) classType;
+(NSArray*) instanceVariablesForClass: (Class) classType includeInheritance: (BOOL) includeInheritance;

+(NSArray*) propertiesForClass: (Class) classType;
+(NSArray*) propertiesForClass: (Class) classType includeInheritance: (BOOL) includeInheritance;

+(PropertyInfo*) infoForProperty: (NSString*) propertyName onClass: (Class) classType;
+(BOOL) continueUpTree: (Class) classType;

@end