//
//  ObjectMapper.m
//  core
//
//  Created by Joshua Gretz on 4/12/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

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
