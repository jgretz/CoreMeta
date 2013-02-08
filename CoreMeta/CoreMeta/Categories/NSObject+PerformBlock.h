//
//  NSObject+PerformBlock.h
//  CoreMeta
//
//  Created by Joshua Gretz on 12/28/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformBlock)

-(void) performBlock: (void (^)(void)) block afterDelay:(NSTimeInterval)delay;
-(void) performBlockInMainThread: (void (^)(void)) block;
@end
