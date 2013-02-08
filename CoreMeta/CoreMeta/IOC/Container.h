//
//  Container.h
//  IOC4IOS
//
//  Created by Joshua Gretz on 12/23/10.
//  Copyright 2010 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContainerConvention.h"

@interface Container : NSObject

+(Container*) sharedContainer;

-(id) objectForKey: (NSString*) key;
-(id) objectForClass: (Class) classType;
-(id) objectForClass: (Class) classType cache: (BOOL) cache;
-(id) objectForClass: (Class) classType withPropertyValues: (NSDictionary*) dictionary;
-(id) objectForProtocol: (Protocol*) protocol;

-(void) put: (id) object;
-(void) put: (id) object forKey: (NSString*) key;
-(void) put: (id) object forClass: (Class) classType;
-(void) put: (id) object forProtocol: (Protocol*) protocol;

-(void) registerClass: (Class) classType;
-(void) registerClass: (Class) classType cache: (BOOL) cache;
-(void) registerClass: (Class) classType cache: (BOOL) cache onCreate: (void(^)(id)) onCreate;

-(void) registerClass: (Class) classType forProtocol: (Protocol*) protocol;
-(void) registerClass: (Class) classType forProtocol: (Protocol*) protocol cache: (BOOL) cache;

-(void) registerClass: (Class) classType forClass: (Class) keyClass;
-(void) registerClass: (Class) classType forClass: (Class) keyClass cache: (BOOL) cache;

-(void) registerClass: (Class) classType forKey: (NSString*) key;
-(void) registerClass: (Class) classType forKey: (NSString*) key cache: (BOOL) cache;
-(void) registerClass: (Class) classType forKey: (NSString*) key cache: (BOOL) cache onCreate: (void(^)(id)) onCreate;

-(void) inject: (id) object;
-(void) inject: (id) object asClass: (Class) classType;

-(void) addConvention: (ContainerConvention*) convention;

@end
