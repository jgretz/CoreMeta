//
//  ClassInfo.m
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


#import "Reflection.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "NSObject+IOC.h"
#import "NSObject+Properties.h"
#import "NSString+Helpers.h"

#pragma mark - Private Category
@interface Reflection() 

@property (strong) NSDictionary* propertyValueTypeMap;
@property (strong) NSArray* ivarValueTypeList;
@property (strong) NSArray* ignoreClasses;

@property (strong) NSMutableDictionary* instanceVariablesForClassCache;
@property (strong) NSMutableDictionary* propertiesForClassCache;

@end

@implementation Reflection

#pragma mark - Shared Singleton
+(Reflection*) sharedReflection {
    static Reflection* sharedReflectionInstance;
    
    @synchronized(self) {
        if (!sharedReflectionInstance) {
            sharedReflectionInstance = [[Reflection alloc] init];
            
            sharedReflectionInstance.propertyValueTypeMap = @{
                @"Tf" : @"float",
                @"Ti" : @"int",
                @"Tc" : @"char",
                @"Td" : @"double",
                @"Tl" : @"long",
                @"Ts" : @"short",
                @"TB" : @"bool",
            };
            
            sharedReflectionInstance.ivarValueTypeList = @[ @"float", @"int", @"char", @"double", @"long", @"short", @"bool", @"f", @"i", @"c", @"d", @"l" ,@"s", @"B", @"@?", @"?"];
            
            sharedReflectionInstance.ignoreClasses = @[ [NSObject class], [UIViewController class], [UIView class], [UITableViewCell class] ];
            
            sharedReflectionInstance.instanceVariablesForClassCache = [NSMutableDictionary dictionary];
            sharedReflectionInstance.propertiesForClassCache = [NSMutableDictionary dictionary];
            
        }
        
        return sharedReflectionInstance;
    }
}

#pragma mark - Class Info
+(Class) superClass: (Class) classType {
    return class_getSuperclass(classType);
}

+(BOOL) continueUpTree:(Class)classType {
    if (!classType)
        return NO;
    
    return ![Reflection.sharedReflection.ignoreClasses containsObject: classType];
}

+(NSArray*) instanceVariablesForClass: (Class) classType  {
    return [Reflection instanceVariablesForClass: classType includeInheritance: NO];
}

+(NSArray*) instanceVariablesForClass: (Class) classType includeInheritance: (BOOL) includeInheritance {
    NSString* key = NSStringFromClass(classType);
    NSArray* cached = Reflection.sharedReflection.instanceVariablesForClassCache[key];
    if (cached)
        return cached;
    
    unsigned int numIvars = 0;
    Ivar* ivars = class_copyIvarList(classType, &numIvars);
    
    NSMutableArray* array = [NSMutableArray array];
    for (int i = 0; i < numIvars; i++) {
        Ivar ivar = ivars[i];
        
        TypeInfo* typeInfo = [[TypeInfo alloc] init];
        typeInfo.name = [NSString stringWithUTF8String: ivar_getName(ivar)];
        typeInfo.typeName = [NSString stringWithUTF8String: ivar_getTypeEncoding(ivar)];
                
        if ([Reflection.sharedReflection.ivarValueTypeList containsObject: typeInfo.typeName])
            typeInfo.valueType = YES;
        
        [array addObject: typeInfo];
    }
    
    free(ivars);
    
    if (includeInheritance) {
        Class parent = [self superClass: classType];
        if ([Reflection continueUpTree: parent])
            [array addObjectsFromArray: [Reflection instanceVariablesForClass: parent includeInheritance: includeInheritance]];
    }
    
    Reflection.sharedReflection.instanceVariablesForClassCache[key] = array;
    return array;
}

+(NSArray*) propertiesForClass:(Class)classType {
    return [Reflection propertiesForClass: classType includeInheritance: NO];
}

+(NSArray*) propertiesForClass: (Class) classType includeInheritance: (BOOL) includeInheritance {
    NSString* key = NSStringFromClass(classType);
    if (!key) {
        return [NSArray array];
    }
    
    NSArray* cached = Reflection.sharedReflection.propertiesForClassCache[key];
    if (cached)
        return cached;
    
    NSMutableArray* array = [NSMutableArray array];
    for (NSString* propertyName in [classType propertyNames])
        [array addObject: [Reflection infoForProperty: propertyName onClass: classType]];
    
    if (includeInheritance) {
        Class parent = [self superClass: classType];
        if ([Reflection continueUpTree: parent])
            [array addObjectsFromArray: [Reflection propertiesForClass: parent includeInheritance: includeInheritance]];
    }
    
    Reflection.sharedReflection.propertiesForClassCache[key] = array;
    return array;
}

+(PropertyInfo*) infoForProperty: (NSString*) propertyName onClass: (Class) classType {
    PropertyInfo* info = [[PropertyInfo alloc] init];
    info.name = propertyName;
    
    NSString* infoString = [NSString stringWithUTF8String: property_getAttributes(class_getProperty(classType, [propertyName UTF8String]))];    
    NSArray* propertyParts = [infoString componentsSeparatedByString: @","];
    
    // set flags
    info.readonly = [propertyParts containsObject: @"R"];
    info.copy = [propertyParts containsObject: @"C"];
    info.retained = [propertyParts containsObject: @"&"];
    info.assign = !(info.copy || info.retained);
    
    // set type name and value type flags
    NSString* typeName = [propertyParts objectAtIndex: 0];
    if ([typeName startsWith: @"T@"]) {
        if (typeName.length >= 5 && [[typeName substringFromIndex: 3] startsWith:@"<"]) {
            info.protocol = YES;
            info.typeName = [[typeName trimLeft: 4] trimRight: 2];
        }
        else {
            info.typeName = [[[propertyParts objectAtIndex: 0] stringByReplacingOccurrencesOfString: @"T@\"" withString: @""] stringByReplacingOccurrencesOfString: @"\"" withString: @""];
        }
    }
    else {
        info.valueType = YES;
        info.typeName = [Reflection.sharedReflection.propertyValueTypeMap objectForKey: [typeName substringToIndex: 2]];
    }
	
    return info;
}

@end
