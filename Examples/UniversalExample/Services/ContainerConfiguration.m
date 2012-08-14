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

#import "ExampleService.h"

#import "ExampleRepository.h"

@implementation ContainerConfiguration

-(void) configure {
    Container* container = [Container sharedContainer];
    [container addConvention: [IdiomContainerConvention convention]];
    
    [container registerClass: [ExampleService class]];
    
    [container registerClass: [ExampleService class] cache: YES];
}

@end
