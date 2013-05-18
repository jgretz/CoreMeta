//
//  NSArray+Helpers.h
//  CoreMeta
//
//  Created by Joshua Gretz on 7/16/12.
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

#import <Foundation/Foundation.h>

@interface NSArray (Helpers)

-(id) first;

-(id) firstWhereKeyPath: (NSString*) keyPath equals: (id) value;
-(NSMutableArray*) whereKeyPath: (NSString*) keyPath equals: (id) value;

-(id) firstWhere: (BOOL(^) (id evaluatedObject)) block;
-(NSArray*) where: (BOOL(^) (id evaluatedObject)) block;

-(id) firstWherePredicate: (NSPredicate*) predicate;
-(NSArray*) wherePredicate: (NSPredicate*) predicate;

-(id) firstWhereBlock: (BOOL (^)(id evaluatedObject, NSDictionary *bindings))block;
-(NSArray*) whereBlock: (BOOL (^)(id evaluatedObject, NSDictionary *bindings))block;

-(NSArray*) select: (id (^)(id evaluatedObject))block;

-(id) objectAtIndexedSubscript: (NSUInteger) index;

@end

@interface NSMutableArray(Helpers)
-(void) reverse;
-(void) setObject: (id) object atIndexedSubscript: (NSUInteger) index;
@end