//
//  Mixin.h
//  CoreMeta
//
//  Created by Joshua Gretz on 3/9/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mixin : NSObject

+(void) mixClass: (Class) source into: (Class) target;
+(void) mixClass: (Class) source into: (Class) target inherit: (BOOL) inherit replaceExistingMethods: (BOOL) replaceExisting;

@end

@interface NSObject (Mixin)

- (void) mixinClass: (Class)source;
- (void) mixinClass: (Class)source inherit: (BOOL) inherit replaceExistingMethods: (BOOL) replaceExisting;

@end