//
//  SkipMixinContainerConvention.h
//  core
//
//  Created by Joshua Gretz on 4/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "ContainerConvention.h"

@interface MixinClassContainerConvention : ContainerConvention

+(MixinClassContainerConvention*) conventionToMixinClass: (Class) source withTest: (BOOL (^)(Class classType)) testBlock;

-(id) initMixinClass: (Class) source withTest: (BOOL (^)(Class classType)) filterBlock;

@end
