//
//  NSObject+IOC.h
//  core
//
//  Created by Joshua Gretz on 3/21/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//



@interface NSObject (IOC)

+(id) object;
+(id) objectWith: (NSDictionary*) propertyValues;

-(void) inject;
-(void) put;

-(void) removeFromIOC;
@end
