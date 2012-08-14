//
//  ObjectMap.m
//  CoreMeta
//
//  Created by Joshua Gretz on 5/24/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "ObjectMap.h"
#import "Reflection.h"
#import "NSArray+Helpers.h"

@implementation ObjectMap

-(void) map:(id)source into:(id)target {
    NSArray* sourceProperties = [Reflection propertiesForClass: [source class] includeInheritance: YES];
    NSArray* targetProperties = [Reflection propertiesForClass: [target class] includeInheritance: YES];
    
    for (PropertyInfo* sourcePropertyInfo in sourceProperties) {
        PropertyInfo* targetPropertyInfo = [targetProperties firstWhereBlock:^BOOL(PropertyInfo* property, NSDictionary *bindings) {
            return [property.name isEqual: sourcePropertyInfo.name] && property.type == sourcePropertyInfo.type;
        }];
        
        if (!targetPropertyInfo || targetPropertyInfo.readonly)
            continue;
        
        [target setValue: [source valueForKey: sourcePropertyInfo.name] forKey: targetPropertyInfo.name];
    }
}

@end
