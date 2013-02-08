//
//  NSDictionary+Helpers.m
//  CoreMeta
//
//  Created by Joshua Gretz on 8/22/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "NSDictionary+Helpers.h"

@implementation NSDictionary (Helpers)

-(id) objectForKeyedSubscript: (id) key {
    return [self objectForKey: key];
}

@end

@implementation NSMutableDictionary (Helpers)

-(void) setObject: (id) object forKeyedSubscript: (id<NSCopying>) key {
    [self setObject: object forKey: key];
}


@end
