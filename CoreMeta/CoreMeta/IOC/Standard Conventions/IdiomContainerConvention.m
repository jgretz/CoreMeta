//
//  IdiomViewControllerContainerConvention.m
//  CoreMeta
//
//  Created by Joshua Gretz on 4/12/12.
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
