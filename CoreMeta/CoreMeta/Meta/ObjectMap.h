//
//  ObjectMap.h
//  core
//
//  Created by Joshua Gretz on 5/24/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectMap : NSObject

-(void) map: (id) source into: (id) target;
-(void) map: (id) source into: (id) target ignoreNilValues: (BOOL) ignoreNilValues;
-(void) map: (id) source into: (id) target ignoreValue: (BOOL(^)(id,NSString*)) ignoreValue;

@end
