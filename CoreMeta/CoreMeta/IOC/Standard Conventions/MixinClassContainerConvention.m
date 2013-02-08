//
//  SkipMixinContainerConvention.m
//  core
//
//  Created by Joshua Gretz on 4/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "MixinClassContainerConvention.h"

@implementation MixinClassContainerConvention {
    Class source;
    BOOL(^testBlock)(Class);
}

+(MixinClassContainerConvention*) conventionToMixinClass: (Class) source withTest: (BOOL (^)(Class classType)) testBlock {
    return [[MixinClassContainerConvention alloc] initMixinClass: source withTest: testBlock];
}

-(id) initMixinClass: (Class) _source withTest: (BOOL (^)(Class classType)) _testBlock {
    if ((self = [super init])) {
        source = _source;
        testBlock = _testBlock;
    }
    
    return self;
}

-(BOOL) respondsToEvent:(enum ContainerConventionEvent)event {
    return event == ApplyMixin;
}

-(Class) classToMixIntoClass: (Class) targetType {
    if (testBlock(targetType))
        return source;
    return nil;
}

@end
