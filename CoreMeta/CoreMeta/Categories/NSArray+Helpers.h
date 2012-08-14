//
//  NSArray+Helpers.h
//  CoreMeta
//
//  Created by Joshua Gretz on 7/16/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Helpers)

-(id) first;

-(id) firstWhereKeyPath: (NSString*) keyPath equals: (id) value;
-(NSMutableArray*) whereKeyPath: (NSString*) keyPath equals: (id) value;

-(id) firstWhere: (NSPredicate*) predicate;
-(NSArray*) where: (NSPredicate*) predicate;

-(id) firstWhereBlock: (BOOL (^)(id evaluatedObject, NSDictionary *bindings))block;
-(NSArray*) whereBlock: (BOOL (^)(id evaluatedObject, NSDictionary *bindings))block;

-(NSArray*) select: (id (^)(id evaluatedObject))block;
@end

@interface NSMutableArray(Helpers)
-(void) reverse;
@end