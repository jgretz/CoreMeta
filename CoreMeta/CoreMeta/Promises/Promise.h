//
// Created by Joshua Gretz on 1/23/15.
// Copyright (c) 2015 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Promise : NSObject

+(Promise*) deferred: (void(^)(Promise*)) action;

-(Promise*) then: (void (^)(id)) onThen;
-(Promise*) then: (void (^)(id)) onThen error: (void(^)(NSError*)) onError;

-(void) resolve: (id) arg;
-(void) reject: (NSError*) arg;

@end