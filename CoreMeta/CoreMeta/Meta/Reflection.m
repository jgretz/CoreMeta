    //
//  ClassInfo.m
//  core
//
//  Created by Joshua Gretz on 3/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "Reflection.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "NSObject+Properties.h"
#import "NSString+Helpers.h"

#pragma mark - Private Category
@interface Reflection() 

@property (retain) NSDictionary* propertyValueTypeMap;
@property (retain) NSArray* ivarValueTypeList;

@end

@implementation Reflection

#pragma mark - Instance Definition
@synthesize propertyValueTypeMap, ivarValueTypeList;

#pragma mark - Singleton
static Reflection* shared;
+(void) initialize {
    static BOOL initialized = NO;
    @synchronized(self) {
        if (!initialized) {
            initialized = YES;
            
            shared = [[Reflection alloc] init];
            shared.propertyValueTypeMap = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: @"float", @"int", @"char", @"double",@"long",@"short",nil] 
                                                                         forKeys: [NSArray arrayWithObjects: @"Tf", @"Ti", @"Tc", @"Td",@"Tl",@"Ts", nil]];
            
            shared.ivarValueTypeList = [NSArray arrayWithObjects: @"float", @"int", @"char", @"double",@"long",@"short",
                                        @"f", @"i", @"c", @"d",@"l",@"s", @"@?", @"?", nil];
        }
    }
}

#pragma mark - Class Info
+(Class) superClass: (Class) classType {
    return class_getSuperclass(classType);
}

+(BOOL) continueUpTree:(Class)classType {
    if (!classType)
        return NO;
    
    NSArray* ignore = [NSArray arrayWithObjects: NSStringFromClass([NSObject class]), NSStringFromClass([UIViewController class]), NSStringFromClass([UIView class]), NSStringFromClass([UITableViewCell class]), nil];
    return ![ignore containsObject: NSStringFromClass(classType)];
}

+(NSArray*) instanceVariablesForClass: (Class) classType  {
    return [Reflection instanceVariablesForClass: classType includeInheritance: NO];
}

+(NSArray*) instanceVariablesForClass: (Class) classType includeInheritance: (BOOL) includeInheritance {
    unsigned int numIvars = 0;
    Ivar* ivars = class_copyIvarList(classType, &numIvars);
    
    NSMutableArray* array = [NSMutableArray array];
    for (int i = 0; i < numIvars; i++) {
        Ivar ivar = ivars[i];
        
        TypeInfo* typeInfo = [[TypeInfo alloc] init];
        typeInfo.name = [NSString stringWithUTF8String: ivar_getName(ivar)];
        typeInfo.typeName = [NSString stringWithUTF8String: ivar_getTypeEncoding(ivar)];
                
        if ([shared.ivarValueTypeList containsObject: typeInfo.typeName])
            typeInfo.valueType = YES;
        
        [array addObject: typeInfo];
    }
    
    free(ivars);
    
    if (includeInheritance) {
        Class parent = [self superClass: classType];
        if ([Reflection continueUpTree: parent])
            [array addObjectsFromArray: [Reflection instanceVariablesForClass: parent includeInheritance: includeInheritance]];
    }
    
    return array;
}

+(NSArray*) propertiesForClass:(Class)classType {
    return [Reflection propertiesForClass: classType includeInheritance: NO];
}

+(NSArray*) propertiesForClass: (Class) classType includeInheritance: (BOOL) includeInheritance {
    NSMutableArray* array = [NSMutableArray array];
    
    for (NSString* propertyName in [classType propertyNames])
        [array addObject: [Reflection infoForProperty: propertyName onClass: classType]];
    
    if (includeInheritance) {
        Class parent = [self superClass: classType];
        if ([Reflection continueUpTree: parent])
            [array addObjectsFromArray: [Reflection propertiesForClass: parent includeInheritance: includeInheritance]];
    }
    
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
        if ([[typeName substringFromIndex: 3] startsWith:@"<"]) {
            info.protocol = YES;
            info.typeName = [[typeName trimLeft: 4] trimRight: 2];
        }
        else {
            info.typeName = [[[propertyParts objectAtIndex: 0] stringByReplacingOccurrencesOfString: @"T@\"" withString: @""] stringByReplacingOccurrencesOfString: @"\"" withString: @""];
        }
    }
    else {
        info.valueType = YES;
        info.typeName = [shared.propertyValueTypeMap objectForKey: [typeName substringToIndex: 2]];
    }
	
    return info;
}

@end
