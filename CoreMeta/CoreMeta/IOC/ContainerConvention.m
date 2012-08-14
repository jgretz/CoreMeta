//
//  ContainerConvention.m
//  CoreMeta
//
//  Created by Joshua Gretz on 4/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "ContainerConvention.h"

@implementation ContainerConvention

-(BOOL) respondsToEvent: (enum ContainerConventionEvent) event {
    return NO;
}

-(Class) mapKey: (NSString*) key {
    return nil;
}

-(Class) mapProtocol: (Protocol*) protocol {
    return nil;
}

-(Class) classToMixIntoClass: (Class) targetType {
    return nil;
}

@end
