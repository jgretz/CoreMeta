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
    
    public class func objectForType(_ t:AnyClass) -> NSObject {
        return CMStaticContainer.container.objectForType(t)
    }

    public class func objectForProtocol<P>(_ p: Protocol) -> P? {
        return CMStaticContainer.container.objectForProtocol(p) as? P
    }

    public func inject() {
        CMStaticContainer.container.inject(self, asType: type(of: self))
    }

    public func injectAsType(_ asType: AnyClass) {
        CMStaticContainer.container.inject(self, asType: asType)
    }

    //*********
    // Storage
    //*********

    public func put() {
        CMStaticContainer.container.put(self)
    }

    public func putAsType(_ asType: AnyClass) {
        CMStaticContainer.container.put(self, asType: asType)
    }

    public func putAsProtocol(_ p: Protocol) {
        CMStaticContainer.container.put(self, p: p)
    }

    //**************
    // Registration
    //**************

    public class func register() {
        CMStaticContainer.container.registerClass(self)
    }

    public class func register(andCache cache: Bool) {
        CMStaticContainer.container.registerClass(self, cache: cache)
    }

    public class func register(andCache cache: Bool, onCreate: @escaping (NSObject) -> Void) {
        CMStaticContainer.container.registerClass(self, cache: cache, onCreate: onCreate)
    }

    public class func registerClassAsClass(_ replacedClass: AnyClass) {
        CMStaticContainer.container.registerClassAsClass(self, replacedClass: replacedClass)
    }

    public class func registerClassAsProtocol(_ p: Protocol) {
        CMStaticContainer.container.registerClassAsProtocol(self, p: p)
    }

}
