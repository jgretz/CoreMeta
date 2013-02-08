//
//  NSArray+Helpers.m
//  Meta-iOS
//
//  Created by Joshua Gretz on 7/16/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

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
