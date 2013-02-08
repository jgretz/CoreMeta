//
//  NSObject+PerformBlock.m
//  CoreMeta
//
//  Created by Joshua Gretz on 12/28/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "NSObject+PerformBlock.h"

@implementation NSObject (PerformBlock)

-(void) performBlock: (void (^)(void)) block afterDelay:(NSTimeInterval)delay {
    int64_t delta = (int64_t)(1.0e9 * delay);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}

-(void) performBlockInMainThread: (void (^)(void)) block {
    dispatch_async(dispatch_get_main_queue(), block);
}

@end