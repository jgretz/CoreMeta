//
// Created by Joshua Gretz on 10/28/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public extension NSObject {
    //**********
    // Creation
    //**********

    // this is the best I can get right now, I'd like to not to have to use a generic here and use Self, but i cant get the return to act right
    class func object<T:NSObject>() -> T {
        return StaticContainer.container.objectForType(self) as! T
    }

    class func objectForProtocol<P>(p: Protocol) -> P? {
        return StaticContainer.container.objectForProtocol(p) as? P
    }

    func inject() {
        StaticContainer.container.inject(self)
    }

    func inject(asType: AnyClass) {
        StaticContainer.container.inject(self, asType: asType)
    }

    //*********
    // Storage
    //*********


    func put() {
        StaticContainer.container.put(self)
    }

    func put(asType: AnyClass) {
        StaticContainer.container.put(self, asType: asType)
    }

    func putAsProtocol(p: Protocol) {
        StaticContainer.container.put(self, p: p)
    }

    //**************
    // Registration
    //**************

    class func register() {
        StaticContainer.container.registerClass(self)
    }

    class func register(cache: Bool) {
        StaticContainer.container.registerClass(self, cache: cache)
    }

    class func registerClass(cache: Bool, onCreate: (NSObject) -> Void) {
        StaticContainer.container.registerClass(self, cache: cache, onCreate: onCreate)
    }

    class func registerClassAsClass(replacedClass: AnyClass) {
        StaticContainer.container.registerClassAsClass(self, replacedClass: replacedClass)
    }

    class func registerClassAsProtocol(p: Protocol) {
        StaticContainer.container.registerClassAsProtocol(self, p: p)
    }

}
