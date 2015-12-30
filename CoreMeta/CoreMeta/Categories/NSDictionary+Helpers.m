//
//  NSDictionary+Helpers.m
//  CoreMeta
//
//  Created by Joshua Gretz on 8/22/12.
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

#import "NSDictionary+Helpers.h"

@implementation NSDictionary (Helpers)

-(id) objectForKeyedSubscript: (id) key {
    return [self objectForKey: key];
}

-(BOOL) containsKey: (id) key {
    return [self.allKeys containsObject: key];
}

@end
