//
//  Container.h
//  CoreMeta
//
//  Created by Joshua Gretz on 12/23/10.
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


#import <Foundation/Foundation.h>
#import "ContainerConvention.h"

@interface Container : NSObject

+(Container*) sharedContainer;

-(id) objectForKey: (NSString*) key;
-(id) objectForClass: (Class) classType;
-(id) objectForClass: (Class) classType cache: (BOOL) cache;
-(id) objectForClass: (Class) classType withPropertyValues: (NSDictionary*) dictionary;
-(id) objectForClass: (Class) classType usingInitSelector: (SEL) selector withArguments: (NSArray*) args;
-(id) objectForProtocol: (Protocol*) protocol;

-(void) put: (id) object;
-(void) put: (id) object forKey: (NSString*) key;
-(void) put: (id) object forClass: (Class) classType;
-(void) put: (id) object forProtocol: (Protocol*) protocol;

-(void) registerClass: (Class) classType;
-(void) registerClass: (Class) classType cache: (BOOL) cache;
-(void) registerClass: (Class) classType cache: (BOOL) cache onCreate: (void(^)(id)) onCreate;
-(void) registerClass: (Class) classType cache: (BOOL) cache usingInitSelector: (SEL) selector withArguments: (NSArray*) args;

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
