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
    public class func object<T:NSObject>() -> T {
        return CMStaticContainer.container.objectForType(self) as! T
    }

    public class func objectForType(t:AnyClass) -> NSObject {
        return CMStaticContainer.container.objectForType(t)
    }

    public class func objectForProtocol<P>(p: Protocol) -> P? {
        return CMStaticContainer.container.objectForProtocol(p) as? P
    }

    public func inject() {
        CMStaticContainer.container.inject(self, asType: self.dynamicType)
    }

    public func inject(asType: AnyClass) {
        CMStaticContainer.container.inject(self, asType: asType)
    }

    //*********
    // Storage
    //*********

    public func put() {
        CMStaticContainer.container.put(self)
    }

    public func put(asType: AnyClass) {
        CMStaticContainer.container.put(self, asType: asType)
    }

    public func putAsProtocol(p: Protocol) {
        CMStaticContainer.container.put(self, p: p)
    }

    //**************
    // Registration
    //**************

    public class func register() {
        CMStaticContainer.container.registerClass(self)
    }

    public class func register(cache: Bool) {
        CMStaticContainer.container.registerClass(self, cache: cache)
    }

    public class func registerClass(cache: Bool, onCreate: (NSObject) -> Void) {
        CMStaticContainer.container.registerClass(self, cache: cache, onCreate: onCreate)
    }

    public class func registerClassAsClass(replacedClass: AnyClass) {
        CMStaticContainer.container.registerClassAsClass(self, replacedClass: replacedClass)
    }

    public class func registerClassAsProtocol(p: Protocol) {
        CMStaticContainer.container.registerClassAsProtocol(self, p: p)
    }

}
