//
//  NSObject+IOC.m
//  CoreMeta
//
//  Created by Joshua Gretz on 3/21/12.
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

#import "NSObject+IOC.h"
#import "Container.h"

@implementation NSObject (IOC)

+(id) object {
    return [[Container sharedContainer] objectForClass: [self class]];
}

+(id) objectWith: (NSDictionary*) propertyValues {
    return [[Container sharedContainer] objectForClass: [self class] withPropertyValues: propertyValues];
}

-(void) inject {
    [[Container sharedContainer] inject: self];
}

-(void) put {
    [[Container sharedContainer] put: self];
}

-(void) putForClass: (Class) classType {
    [[Container sharedContainer] put: self forClass: classType];
}


-(void) removeFromIOC {
    [[Container sharedContainer] put: nil forClass: [self class]];
}

@end
