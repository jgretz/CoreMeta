//
// Created by Joshua Gretz on 11/4/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

@objc protocol CMContainerProtocol {
    func registerClass(t: AnyClass)

    func registerClass(t: AnyClass, cache: Bool)

    func registerClass(t: AnyClass, cache: Bool, onCreate: (NSObject) -> Void)

    func registerClassAsClass(returnedClass: AnyClass, replacedClass: AnyClass)

    func registerClassAsProtocol(t: AnyClass, p: Protocol)

    func autoregister()

    //*********
    // Storage
    //*********

    func put(obj: AnyObject)

    func put(object: AnyObject, asType: AnyClass)

    func put(object: AnyObject, p: Protocol)

    func clear()

    func clearClass(t: AnyClass)

    func clearProtocol(p: Protocol)

    //**********
    // Creation
    //**********

    func objectForProtocol(p: Protocol) -> NSObject?

    func objectForType(t: AnyClass) -> NSObject

    func inject(obj: NSObject)

    func inject(obj: NSObject, asType: AnyClass)
}
