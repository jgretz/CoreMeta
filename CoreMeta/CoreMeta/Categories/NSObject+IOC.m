//
//  NSObject+IOC.m
//  core
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

+(id) objectWith: (NSDictionary*) propertyValues {
    return [[Container sharedContainer] objectForClass: [self class] withPropertyValues: propertyValues];
}

-(void) inject {
    [[Container sharedContainer] inject: self];
}

-(void) put {
    [[Container sharedContainer] put: self];
}

-(void) removeFromIOC {
    [[Container sharedContainer] put: nil forClass: [self class]];
}

@end
