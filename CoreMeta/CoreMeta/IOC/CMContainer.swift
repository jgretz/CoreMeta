//
// Created by Joshua Gretz on 10/20/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public class CMContainer {
    let registrationMap: CMContainerRegistrationMap
    let cache: CMContainerCache

    public init() {
        self.registrationMap = CMContainerRegistrationMap()
        self.cache = CMContainerCache()
    }

    //**************
    // Registration
    //**************

    public func registerClass(t: AnyClass) {
        self.registerClass(t, cache: false)
    }

    public func registerClass(t: AnyClass, cache: Bool) {
        self.registrationMap.addRegistration(CMContainerClassRegistration(type: t, cache: cache, onCreate: nil))
    }

    public func registerClass(t: AnyClass, cache: Bool, onCreate: (NSObject) -> Void) {
        self.registrationMap.addRegistration(CMContainerClassRegistration(type: t, cache: false, onCreate: onCreate))
    }

    public func registerClassAsClass(returnedClass: AnyClass, replacedClass: AnyClass) {
        self.registrationMap.addTypeMap(CMContainerClassRegistrationMap(returnedClass: returnedClass, replacedClass: replacedClass))
    }

    public func registerClassAsProtocol(t: AnyClass, p: Protocol) {
        self.registrationMap.addProtocolMap(CMContainerProtocolRegistrationMap(returnedClass: t, forProtocol: p))
    }

    //*********
    // Storage
    //*********

    public func put(obj: AnyObject) {
        self.put(obj, type: obj.dynamicType)
    }

    public func put(object: AnyObject, type: AnyClass) {
        if (!self.registrationMap.isTypeRegistered(type)) {
            self.registerClass(type)
        }

        self.cache[type] = object
    }

    public func put(object: AnyObject, p: Protocol) {
        let type:AnyClass = self.registrationMap.isProtocolRegistered(p) ? self.registrationMap.registrationForProtocol(p)!.returnedClass : object.dynamicType

        self.put(object, type: type)
    }

    public func clear() {
        self.cache.clear()
    }

    public func clearClass(t: AnyClass) {
        self.cache.clear(t)
    }

    public func clearProtocol(p: Protocol) {
        let reg = self.registrationMap.registrationForProtocol(p)
        if (reg == nil) {
            return
        }

        self.cache.clear(reg!.returnedClass)
    }

    //**********
    // Creation
    //**********

    public func objectForType(t: AnyClass) -> NSObject {
        let reg = self.registrationMap.registrationForType(t)

        if (reg != nil && self.cache.hasType(reg!.type)) {
            return self.cache[reg!.type] as! NSObject
        }

        let introspector = reg == nil ? CMTypeIntrospector(t: t) : reg!.typeIntrospector

        let type = NSClassFromString(NSStringFromClass(introspector.type)) as! NSObject.Type
        let obj = type.init()

        return obj
    }

    public func objectForProtocol(p: Protocol) -> NSObject? {
        let reg = self.registrationMap.registrationForProtocol(p)

        return reg == nil ? nil : self.objectForType(reg!.returnedClass)
    }

}