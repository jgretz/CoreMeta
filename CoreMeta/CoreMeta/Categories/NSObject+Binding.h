//
//  NSObject+Binding.h
//  CoreMeta
//
//  Created by Joshua Gretz on 5/23/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Binding)

-(void) bindForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath;
-(void) bindForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath withManipulation: (id (^)(id)) manipulation;
-(void) unbindForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath;

-(void) bindBothForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath;
-(void) bindBothForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath withManipulation: (id (^)(id)) manipulation;
-(void) unbindBothForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath;

@end
