//
//  Binder.h
//  CoreMeta
//
//  Created by Joshua Gretz on 5/23/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Binder : NSObject

-(void) bind: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath;
-(void) bind: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath withManipulation: (id (^)(id)) manipulation;
-(void) unbind: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath;

-(void) bindBoth: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath;
-(void) bindBoth: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath withManipulation: (id (^)(id)) manipulation;
-(void) unbindBoth: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath;

+(Binder*) sharedBinder;

@end
