//
//  NSDictionary+Helpers.h
//  CoreMeta
//
//  Created by Joshua Gretz on 8/22/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Helpers)

-(id) objectForKeyedSubscript: (id) key;

@end

@interface NSMutableDictionary (Helpers)

-(void) setObject: (id) object forKeyedSubscript: (id<NSCopying>) key;

@end
