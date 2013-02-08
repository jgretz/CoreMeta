//
//  ObjectMap.m
//  core
//
//  Created by Joshua Gretz on 5/24/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "ObjectMap.h"
#import "Reflection.h"
#import "NSDictionary+Helpers.h"

@implementation ObjectMap

-(void) map:(id)source into:(id)target {
    NSArray* sourceProperties = [Reflection propertiesForClass: [source class] includeInheritance: YES];
    
    NSMutableDictionary* targetProperties = [NSMutableDictionary dictionary];
    for (PropertyInfo* targetProperyInfo in [Reflection propertiesForClass: [target class] includeInheritance: YES])
        targetProperties[targetProperyInfo.name.uppercaseString] = targetProperyInfo;
    
    for (PropertyInfo* sourcePropertyInfo in sourceProperties) {
        PropertyInfo* targetPropertyInfo = targetProperties[sourcePropertyInfo.name.uppercaseString];
        if (!targetPropertyInfo || targetPropertyInfo.readonly || targetPropertyInfo.type != sourcePropertyInfo.type)
            continue;
        
        [target setValue: [source valueForKey: sourcePropertyInfo.name] forKey: targetPropertyInfo.name];
    }
}

@end
