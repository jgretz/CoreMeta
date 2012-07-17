//
//  IdiomViewControllerContainerConvention.m
//  core
//
//  Created by Joshua Gretz on 4/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IdiomContainerConvention.h"

@implementation IdiomContainerConvention {
    NSString* prefix;
}

+(IdiomContainerConvention*) convention {
    return [[IdiomContainerConvention alloc] init];
}

-(id) init {
    if ((self = [super init])) {
        prefix = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"iPad" : @"iPhone";
    }
    
    return self;
}

-(BOOL) respondsToEvent:(enum ContainerConventionEvent)event {
    return event == MapClass;
}

-(Class) mapKey:(NSString *)key {
    if (!key || key.length == 0)
        return nil;
    return NSClassFromString([NSString stringWithFormat: @"%@%@", prefix, key]);
}

@end
