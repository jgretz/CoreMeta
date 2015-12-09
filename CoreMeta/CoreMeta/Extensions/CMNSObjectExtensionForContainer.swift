//
// Created by Joshua Gretz on 10/28/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public extension NSObjectProtocol {
    
    //**********
    // Creation
    //**********
    
    public static func object() -> Self {
        return CMStaticContainer.container.objectForType(self) as! Self
    }
}

public extension NSObject {
    
    //**********
    // Creation
    //**********
    
    public class func objectForType(t:AnyClass) -> NSObject {
        return CMStaticContainer.container.objectForType(t)
    }

    public class func objectForProtocol<P>(p: Protocol) -> P? {
        return CMStaticContainer.container.objectForProtocol(p) as? P
    }

    public func inject() {
        CMStaticContainer.container.inject(self, asType: self.dynamicType)
    }

    public func injectAsType(asType: AnyClass) {
        CMStaticContainer.container.inject(self, asType: asType)
    }

    //*********
    // Storage
    //*********

    public func put() {
        CMStaticContainer.container.put(self)
    }

    public func putAsType(asType: AnyClass) {
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

    public class func register(cache: Bool, onCreate: (NSObject) -> Void) {
        CMStaticContainer.container.registerClass(self, cache: cache, onCreate: onCreate)
    }

    public class func registerClassAsClass(replacedClass: AnyClass) {
        CMStaticContainer.container.registerClassAsClass(self, replacedClass: replacedClass)
    }

    public class func registerClassAsProtocol(p: Protocol) {
        CMStaticContainer.container.registerClassAsProtocol(self, p: p)
    }

}
