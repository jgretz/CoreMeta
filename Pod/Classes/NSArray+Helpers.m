//
//  NSArray+Helpers.m
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

#import "NSArray+Helpers.h"

@implementation NSArray (Helpers)

-(id) first {
	return self.count > 0 ? [self objectAtIndex: 0] : nil;
}

-(id) firstWhereKeyPath: (NSString*) keyPath equals: (id) value {
	for (id obj in self) {
		id objVal = [obj valueForKeyPath: keyPath];
		if ([objVal isEqual: value])
			return obj;
	}
    
	return nil;
}

-(NSMutableArray*) whereKeyPath: (NSString*) keyPath equals: (id) value {
	NSMutableArray* array = [NSMutableArray array];
	for (id obj in self) {
		id objVal = [obj valueForKeyPath: keyPath];
		if ([objVal isEqual: value])
			[array addObject: obj];
	}
	
	return array;	
}

-(id) firstWhere: (BOOL(^) (id evaluatedObject)) block {
    return [self firstWhereBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) { return block(evaluatedObject); }];
    
}

-(NSArray*) where: (BOOL(^) (id evaluatedObject)) block {
    return [self whereBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) { return block(evaluatedObject); }];
}

-(id) firstWherePredicate: (NSPredicate*) predicate {
    return [[self filteredArrayUsingPredicate: predicate] first];
}

-(NSArray*) wherePredicate: (NSPredicate*) predicate {
    return [self filteredArrayUsingPredicate: predicate];
}

-(id) firstWhereBlock: (BOOL (^)(id evaluatedObject, NSDictionary *bindings))block {
    return [self firstWherePredicate: [NSPredicate predicateWithBlock: block]];
}

-(NSArray*) whereBlock: (BOOL (^)(id evaluatedObject, NSDictionary *bindings))block {
    return [self wherePredicate: [NSPredicate predicateWithBlock: block]];
}

-(NSArray*) select: (id (^)(id evaluatedObject))block {
    NSMutableArray* array = [NSMutableArray array];
    for (id obj in self)
        [array addObject: block(obj)];
    return array;
}

-(id) objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex: index];
}

@end

@implementation NSMutableArray(Helpers)

-(void) reverse {
    if (self.count == 0)
        return;
    
    NSUInteger i = 0;
    NSUInteger j = [self count] - 1;
    while (i < j) {
        [self exchangeObjectAtIndex:i
                  withObjectAtIndex:j];
        
        i++;
        j--;
    }
}

-(void) setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    if (!object)
        [NSException raise: NSInvalidArgumentException format:@"setObject:atIndexedSubscript does not allow objects to be nil"];
    
    if (index > self.count)
        [NSException raise:NSRangeException format:@"setObject:atIndexedSubscript does not allow the index to be out of array bounds"];
    
    if (index == self.count)
        [self addObject: object];
    else
        [self replaceObjectAtIndex: index withObject: object];
}

@end
