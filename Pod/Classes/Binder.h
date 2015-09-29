//
//  Binder.h
//  CoreMeta
//
//  Created by Joshua Gretz on 5/23/12.
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

@interface Binder : NSObject

-(void) bind: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath;
-(void) bind: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath withManipulation: (id (^)(id)) manipulation;
-(void) unbind: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath;

-(void) bindBoth: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath;
-(void) bindBoth: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath withManipulation: (id (^)(id)) manipulation;
-(void) unbindBoth: (NSObject*) object1 keypath: (NSString*) object1_keypath to: (NSObject*) object2 keypath: (NSString*) object2_keypath;

+(Binder*) sharedBinder;

@end
