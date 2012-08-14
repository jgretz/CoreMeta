//
//  NSObject+IOC.m
//  CoreMeta
//
//  Created by Joshua Gretz on 3/21/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "NSObject+IOC.h"
#import "Container.h"

@implementation NSObject (IOC)

+(id) object {
    return [[Container sharedContainer] objectForClass: [self class]];
}

@end
