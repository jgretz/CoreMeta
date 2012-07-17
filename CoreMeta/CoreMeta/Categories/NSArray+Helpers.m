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

-(id) firstWhere: (NSPredicate*) predicate {
    return [[self filteredArrayUsingPredicate: predicate] first];
}

-(NSArray*) where: (NSPredicate*) predicate {
    return [self filteredArrayUsingPredicate: predicate];
}

-(id) firstWhereBlock: (BOOL (^)(id evaluatedObject, NSDictionary *bindings))block {
    return [self firstWhere: [NSPredicate predicateWithBlock: block]];
}

-(NSArray*) whereBlock: (BOOL (^)(id evaluatedObject, NSDictionary *bindings))block {
    return [self where: [NSPredicate predicateWithBlock: block]];
}

-(NSArray*) select: (id (^)(id evaluatedObject))block {
    NSMutableArray* array = [NSMutableArray array];
    for (id obj in self)
        [array addObject: block(obj)];
    return array;
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

@end
