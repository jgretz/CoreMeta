//
//  SkipMixinContainerConvention.m
//  CoreMeta
//
//  Created by Joshua Gretz on 4/12/12.
//
/* Copyright 2011 TrueFit Solutions
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


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
