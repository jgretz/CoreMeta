//
//  NSString+Helpers.h
//  CoreMeta
//
//  Created by Joshua Gretz on 7/16/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helpers)

-(NSString*) trimLeft: (int) length;
-(NSString*) trimRight: (int) length;
-(NSString*) trimWhiteSpaceLeft;
-(NSString*) trimWhiteSpaceRight;

-(NSString*) substring: (int) length start: (int) index;

-(BOOL) isNilOrEmpty;
-(BOOL) contains: (NSString*) search;
-(BOOL) startsWith: (NSString*) search;

-(NSString*) properCaseAtSpace;
-(NSString*) insertSpaceBeforeProperCase;
-(NSString*) xmlSimpleEscape;

-(NSString*) padLeftToLength: (int) length;
-(NSString*) padRightToLength: (int) length;
-(NSString*) padBothToLength: (int) length;

+(NSString*) fromInt: (int) value;
+(NSString*) newStringWithUUID;

@end
