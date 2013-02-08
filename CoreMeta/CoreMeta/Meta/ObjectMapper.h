//
//  ObjectMapper.h
//  core
//
//  Created by Joshua Gretz on 4/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

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
