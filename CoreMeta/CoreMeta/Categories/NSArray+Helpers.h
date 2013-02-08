//
//  NSArray+Helpers.h
//  Meta-iOS
//
//  Created by Joshua Gretz on 7/16/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

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