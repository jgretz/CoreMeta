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
        return CMStaticContainer.container.objectForType(self) as! T
    }

    class func objectForProtocol<P>(p: Protocol) -> P? {
        return CMStaticContainer.container.objectForProtocol(p) as? P
    }

    func inject() {
        CMStaticContainer.container.inject(self)
    }

    func inject(asType: AnyClass) {
        CMStaticContainer.container.inject(self, asType: asType)
    }

    //*********
    // Storage
    //*********


    func put() {
        CMStaticContainer.container.put(self)
    }

    func put(asType: AnyClass) {
        CMStaticContainer.container.put(self, asType: asType)
    }

    func putAsProtocol(p: Protocol) {
        CMStaticContainer.container.put(self, p: p)
    }

    //**************
    // Registration
    //**************

    class func register() {
        CMStaticContainer.container.registerClass(self)
    }

    class func register(cache: Bool) {
        CMStaticContainer.container.registerClass(self, cache: cache)
    }

    class func registerClass(cache: Bool, onCreate: (NSObject) -> Void) {
        CMStaticContainer.container.registerClass(self, cache: cache, onCreate: onCreate)
    }

    class func registerClassAsClass(replacedClass: AnyClass) {
        CMStaticContainer.container.registerClassAsClass(self, replacedClass: replacedClass)
    }

    class func registerClassAsProtocol(p: Protocol) {
        CMStaticContainer.container.registerClassAsProtocol(self, p: p)
    }

}
