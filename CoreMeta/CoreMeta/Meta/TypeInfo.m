//
//  IVarInfo.m
//  CoreMeta
//
//  Created by Joshua Gretz on 3/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "TypeInfo.h"

@implementation TypeInfo

@synthesize name, typeName, protocol, valueType;

-(Class) type {
    return NSClassFromString(self.typeName);
}

@end
