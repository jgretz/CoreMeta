//
//  IVarInfo.h
//  CoreMeta
//
//  Created by Joshua Gretz on 3/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeInfo : NSObject

@property (copy) NSString* name;
@property (copy) NSString* typeName;

@property (readonly) Class type;

@property BOOL valueType;
@property BOOL protocol;

@end
