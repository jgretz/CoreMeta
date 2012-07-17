//
//  ContainerConvention.h
//  core
//
//  Created by Joshua Gretz on 4/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

enum ContainerConventionEvent {
    MapClass = 0,
    MapProtocol = 1,
    ApplyMixin = 2
};

@interface ContainerConvention : NSObject

-(BOOL) respondsToEvent: (enum ContainerConventionEvent) event;

-(Class) mapKey: (NSString*) key;
-(Class) mapProtocol: (Protocol*) protocol;
-(Class) classToMixIntoClass: (Class) targetType;

@end
