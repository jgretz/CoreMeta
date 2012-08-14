//
//  ObjectMapper.m
//  CoreMeta
//
//  Created by Joshua Gretz on 4/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "ObjectMapper.h"
#import "NSObject+IOC.h"

@implementation ObjectMapper

+(void) map: (id) source into: (id) target {
    [ObjectMapper map: source into: target withMap: [ObjectMap object]];
}

+(void) map: (id) source into:(id)target withMap: (ObjectMap*) map {
    [map map: source into: target];
}

+(id) create: (Class) classType from: (id) source {
    return [ObjectMapper create: classType from: source withMap: [ObjectMap object]];
}

+(id) create: (Class) classType from: (id) source withMap: (ObjectMap*) map {
    id object = [classType object];
    [ObjectMapper map: source into: object withMap: map];
    
    return object;
}

@end
