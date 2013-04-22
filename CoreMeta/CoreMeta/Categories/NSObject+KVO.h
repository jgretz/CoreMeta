//
//  NSObject+KVO.h
//  core
//
//  Created by Joshua Gretz on 4/17/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OBJECT_KEYPATH(object, property) ((void)(NO && ((void)object.property, NO)), @#property)
#define SELF_KEYPATH(property) OBJECT_KEYPATH(self, property)
#define CLASS_KEYPATH(class, property) OBJECT_KEYPATH([class new], property)

@interface NSObject (KVO)

-(void) when: (NSString*) keyPath changes: (void (^)()) block;
-(void) when: (NSString*) keyPath becomes: (BOOL (^)()) testBlock do: (void (^)()) block;

-(void) when: (NSString*) keyPath changesExecute: (void (^)(id, NSDictionary*)) block;
-(void) when: (NSString*) keyPath becomes: (BOOL (^)(id, NSDictionary*)) testBlock execute: (void (^)(id, NSDictionary *))block;

-(void) clearKVO;
-(void) clearKVOForPath: (NSString*) keyPath;

@end
