//
//  NSObject+PerformBlock.m
//  CoreMeta
//
//  Created by Joshua Gretz on 12/28/12.
//
/* Copyright 2011 TrueFit Solutions
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "NSObject+Perform.h"

@implementation NSObject (Perform)

-(void) performBlock: (void (^)(void)) block afterDelay:(NSTimeInterval)delay {
    int64_t delta = (int64_t)(1.0e9 * delay);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}

-(void) performBlockInMainThread: (void (^)(void)) block {
    dispatch_async(dispatch_get_main_queue(), block);
}

-(void) performBlockInBackground: (void (^)(void)) block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
}

-(void) performSelectorInBackground: (SEL) selector withObject: (id) object afterDelay: (NSTimeInterval) delay {
    [self performBlockInMainThread: ^{
        [self performBlock: ^{
            [self performSelectorInBackground: selector withObject: object];
        } afterDelay: delay];
    }];
}

@end