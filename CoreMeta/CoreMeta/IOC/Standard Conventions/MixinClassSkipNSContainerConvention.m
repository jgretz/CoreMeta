//
//  SkipNSClassContainerConvention.m
//  core
//
//  Created by Joshua Gretz on 4/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "MixinClassSkipNSContainerConvention.h"
#import "NSString+Helpers.h"

@implementation MixinClassSkipNSContainerConvention

+(MixinClassSkipNSContainerConvention*) conventionToMixinOfClass: (Class) source {
    return [[MixinClassSkipNSContainerConvention alloc] initToMixinOfClass: source];
}

-(id) initToMixinOfClass: (Class) source {
    self = [super initMixinClass: source withTest:^BOOL(Class classType) {
        return ![NSStringFromClass(classType) startsWith: @"NS"];
    }];
    
    return self;
}

@end
