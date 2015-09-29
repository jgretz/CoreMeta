//
// Created by Joshua Gretz on 1/23/15.
// Copyright (c) 2015 TrueFit Solutions. All rights reserved.



#import "Promise.h"
#import "NSObject+IOC.h"
#import "NSObject+Perform.h"

@interface Promise()

@property (strong) Promise* chain;

@property (strong) id resolveResult;
@property (strong) NSError* errorResult;

@property (strong) void(^action)(Promise*);
@property (strong) void(^then)(id);
@property (strong) void(^error)(id);

@end

@implementation Promise

+(Promise*) deferred: (void (^)(Promise*)) action {
    Promise* promise = [Promise object];
    promise.action = action;

    [promise execute];

    return promise;
}

+(Promise*) chain: (void (^)(Promise*)) action ontoPromise: (Promise*) leftPromise {
    Promise* promise = [Promise object];
    promise.action = action;

    leftPromise.chain = promise;

    return promise;
}

-(Promise*) then: (void (^)(id)) onThen {
    return [self then: onThen error: nil];
}

-(Promise*) then: (void (^)(id)) onThen error: (void (^)(NSError*)) onError {
    self.then = onThen;
    self.error = onError;

    __block Promise* _self = self;
    return [Promise chain: ^(Promise* promise) {
        @try {
            [promise resolve: _self.resolveResult];
        }
        @catch (NSError* error) {
            [promise reject: error];
        }
    } ontoPromise: self];
}

-(void) execute {
    __block Promise* _self = self;
    [self performBlock: ^{_self.action(_self);} afterDelay: 0];
}

-(void) resolve: (id) arg {
    if (self.then) {
        self.then(arg);
    }

    if (self.chain) {
        self.resolveResult = arg;
        [self.chain execute];
    }
}

-(void) reject: (NSError*) error {
    if (self.error) {
        self.error(error);
    }

    if (self.chain) {
        [self.chain reject: error];
    }
}

@end