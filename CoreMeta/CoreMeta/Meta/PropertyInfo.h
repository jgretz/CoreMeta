//
//  PropertyInfo.h
//  CoreMeta
//
//  Created by Joshua Gretz on 3/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeInfo.h"

@interface PropertyInfo : TypeInfo

@property BOOL readonly;
@property BOOL assign;
@property BOOL copy;
@property BOOL retained;

@end
