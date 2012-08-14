//
//  SkipNSClassContainerConvention.h
//  CoreMeta
//
//  Created by Joshua Gretz on 4/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "MixinClassContainerConvention.h"

@interface MixinClassSkipNSContainerConvention : MixinClassContainerConvention

+(MixinClassSkipNSContainerConvention*) conventionToMixinOfClass: (Class) source;

-(id) initToMixinOfClass: (Class) source;

@end
