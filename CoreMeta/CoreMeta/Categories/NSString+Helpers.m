//
//  NSString+Helpers.m
//  Meta-iOS
//
//  Created by Joshua Gretz on 7/16/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "NSString+Helpers.h"

@implementation NSString (Helpers)

-(NSString*) trimLeft: (int) length {
	return [self substringFromIndex: length];
}

-(NSString*) trimRight: (int) length {
	return [self substringToIndex: self.length - length];
}

-(NSString*) trimWhiteSpaceLeft {
    for (int i = 0; i < self.length; i++) {
        NSString* test = [self substring: 1 start: i];
        if (![test isEqual: @" "])
            return [self substringFromIndex: i];
    }
    
    return @"";
}

-(NSString*) trimWhiteSpaceRight {
    for (int i = self.length - 1; i > 0; i--) {
        NSString* test = [self substring: 1 start: i];
        if (![test isEqual: @" "])
            return [self substringToIndex: i + 1];
    }
    
    return @"";
}

-(NSString*) substring: (int) length start: (int) index {
	return [self substringWithRange: NSMakeRange(index, length)];
}

-(BOOL) isNilOrEmpty {
    return !self || self.length == 0;
}

-(BOOL) contains: (NSString*) search {
	NSRange range = [self rangeOfString: search];
    
    int location = range.location;
	return location >= 0 && location < self.length;	
}

-(BOOL) startsWith: (NSString*) search {
	NSRange range = [self rangeOfString: search];
    
    int location = range.location;
	return location == 0;
}

-(BOOL) endsWith: (NSString*) search {
    NSRange range = [self rangeOfString: search];
    
    int location = range.location;
	return location == self.length - search.length;
}

-(NSString*) properCaseAtSpace {
    NSMutableString* string = [NSMutableString string];
    
    BOOL flag = YES;
    for (int i = 0; i < self.length; i++) {
        NSString* character = [self substring: 1 start: i];
        if ([character isEqual: @" "]) {
            flag = YES;
            continue;
        }
        
        [string appendString: flag ? [character uppercaseString] : character];
        
        flag = NO;
    }
    
    return string;
}

-(NSString*) insertSpaceBeforeProperCase {
    NSMutableString* string = [NSMutableString stringWithString: [[self substring: 1 start: 0] uppercaseString]];
    
    for (int i = 1; i < self.length; i++) {
        NSString* character = [self substring: 1 start: i];
        if ([character isEqual: [character uppercaseString]])
            [string appendString: @" "];
        [string appendString: character];
    }
    
    return string;
}

-(NSString*) xmlSimpleEscape {
    NSMutableString* string = [NSMutableString stringWithString: self];
    
    [string replaceOccurrencesOfString:@"&"  withString:@"&amp;"  options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"'"  withString:@"&#x27;" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@">"  withString:@"&gt;"   options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"<"  withString:@"&lt;"   options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    
    return string;
}

-(NSString*) padLeftToLength: (int) length {
    NSString* str = [self copy];
    while (str.length < length)
        str = [@" " stringByAppendingString: str];
    return str;
}

-(NSString*) padRightToLength: (int) length {
    NSString* str = [self copy];
    while (str.length < length)
        str = [str stringByAppendingString: @" "];
    return str;
}

-(NSString*) padBothToLength: (int) length {
    NSString* str = [self copy];
    BOOL flag = NO;
    while (str.length < length) {
        str = flag ? [str stringByAppendingString: @" "] : [@" " stringByAppendingString: str];
        flag = !flag;
    }
    return str;
}

+(NSString*) stringFromInt: (int) value {
    return [NSString stringWithFormat: @"%i", value];
}

+(NSString*) stringFromFloat: (float) value {
    return [NSString stringFromFloat: value format: @"%f"];
}

+(NSString*) stringFromFloat: (float) value format: (NSString*) format {
    return [NSString stringWithFormat: format, value];
}

+(NSString*) newStringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(nil);
    CFStringRef stringRef = CFUUIDCreateString(nil, uuid);
    
    NSString* result = (__bridge NSString*) stringRef;
    
    CFRelease(stringRef);
    CFRelease(uuid);
    
    return result;
}

@end
