//
// Created by Joshua Gretz on 11/4/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

@objc protocol CMContainerProtocol {
    func registerClass(_ t: AnyClass)

    func registerClass(_ t: AnyClass, cache: Bool)

    func registerClass(_ t: AnyClass, cache: Bool, onCreate: @escaping (NSObject) -> Void)

    func registerClassAsClass(_ returnedClass: AnyClass, replacedClass: AnyClass)

    func registerClassAsProtocol(_ t: AnyClass, p: Protocol)

    func autoregister()

    //*********
    // Storage
    //*********

    func put(_ obj: AnyObject)

    func put(_ object: AnyObject, asType: AnyClass)

    func put(_ object: AnyObject, p: Protocol)

    func clear()

    func clearClass(_ t: AnyClass)

    func clearProtocol(_ p: Protocol)

    //**********
    // Creation
    //**********

    func objectForProtocol(_ p: Protocol) -> NSObject?

    func objectForType(_ t: AnyClass) -> NSObject

    func inject(_ obj: NSObject)

    func inject(_ obj: NSObject, asType: AnyClass)
}
