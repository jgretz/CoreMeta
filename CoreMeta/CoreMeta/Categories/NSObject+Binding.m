//
//  NSObject+Binding.m
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

#import "NSObject+Binding.h"
#import "Binder.h"

@implementation NSObject (Binding)

-(void) bindForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath {
    [[Binder sharedBinder] bind: self keypath: selfKeyPath to: object keypath: objectKeyPath];
}

-(void) bindForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath withManipulation: (id (^)(id)) manipulation {
    [[Binder sharedBinder] bind: self keypath: selfKeyPath to: object keypath: objectKeyPath withManipulation: manipulation];
}

-(void) unbindForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath; {
    [[Binder sharedBinder] unbind: self keypath: selfKeyPath to: object keypath: objectKeyPath];
}

-(void) bindBothForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath {
    [[Binder sharedBinder] bindBoth: self keypath: selfKeyPath to: object keypath: objectKeyPath];
}

-(void) bindBothForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath withManipulation: (id (^)(id)) manipulation {
    [[Binder sharedBinder] bindBoth: self keypath: selfKeyPath to: object keypath: objectKeyPath withManipulation: manipulation];
}

-(void) unbindBothForKeyPath: (NSString*) selfKeyPath to: (NSObject*) object keyPath: (NSString*) objectKeyPath {
    [[Binder sharedBinder] unbindBoth: self keypath: selfKeyPath to: object keypath: objectKeyPath];
}

@end
