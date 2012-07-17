//
//  ContainerConfiguration.m
//  UniversalExample
//
//  Created by Joshua Gretz on 7/16/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "ContainerConfiguration.h"
#import "Container.h"
#import "IdiomContainerConvention.h"

@implementation ContainerConfiguration

-(void) configure {
    Container* container = [Container sharedContainer];
    [container addConvention: [IdiomContainerConvention convention]];
}

@end
