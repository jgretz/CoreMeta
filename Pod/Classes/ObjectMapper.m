//
//  ObjectMapper.m
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


#import "ObjectMapper.h"
#import "NSObject+IOC.h"

@interface ObjectMapper()

@property (strong) NSMutableDictionary* mapRegistration;

@end

@implementation ObjectMapper

#pragma mark - Interface
+(void) map: (id) source into: (id) target {
    [ObjectMapper map: source into: target withMap: [[ObjectMapper sharedMapper] mapForObject: source into: target]];
}

+(void) map: (id) source into: (id) target withMapOfType: (Class) classType {
    [ObjectMapper map: source into: target withMap: [classType object]];
}

+(void) map: (id) source into: (id) target withMap: (ObjectMap*) map {
    [map map: source into: target];
}

+(id) create: (Class) classType from: (id) source {
    return [ObjectMapper create: classType from: source withMap: [[ObjectMapper sharedMapper] mapForClass: [source class] into: classType]];
}

+(id) create: (Class) classType from: (id) source withMapOfType: (Class) mapClassType {
    return [ObjectMapper create: classType from: source withMap: [mapClassType object]];
}

+(id) create: (Class) classType from: (id) source withMap: (ObjectMap*) map {
    id object = [classType object];
    [ObjectMapper map: source into: object withMap: map];
    
    return object;
}

+(void) registerMap: (Class) objectMap forClass: (Class) source toClass: (Class) target {
    [[ObjectMapper sharedMapper] registerMap: objectMap forClass: source toClass: target];
}

#pragma mark - Implementation

#pragma mark - Shared Singleton
+(ObjectMapper*) sharedMapper {
    static ObjectMapper* sharedMapperInstance;
    
    @synchronized(self) {
        if (!sharedMapperInstance)
            sharedMapperInstance = [ObjectMapper object];
        
        return sharedMapperInstance;
    }
}

#pragma mark - Init
-(id) init {
    if ((self = [super init])) {
        self.mapRegistration = [NSMutableDictionary dictionary];
    }
    
    return self;
}

#pragma mark - Logic
-(ObjectMap*) mapForObject: (id) source into: (id) target {
    return [self mapForClass: [source class] into: [target class]];
}

-(ObjectMap*) mapForClass: (Class) source into: (Class) target {
    Class defined = self.mapRegistration[[self keyFor: source to: target]];
    return defined ? [defined object] : [ObjectMap object];
}

-(void) registerMap: (Class) objectMap forClass: (Class) source toClass: (Class) target {
    self.mapRegistration[[self keyFor: source to: target]] = objectMap;
}

-(NSString*) keyFor: (Class) source to: (Class) target {
    return [NSString stringWithFormat: @"%@_%@", NSStringFromClass(source), NSStringFromClass(target)];
}

@end
