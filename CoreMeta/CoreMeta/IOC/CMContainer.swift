//
// Created by Joshua Gretz on 10/20/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public class CMContainer {
    let registrationMap: CMContainerRegistrationMap
    let cache: CMContainerCache

    init() {
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
        self.registrationMap.addRegistration(CMContainerClassRegistration(type: t, cache: cache, onCreate: onCreate))
    }

    public func registerClassAsClass(returnedClass: AnyClass, replacedClass: AnyClass) {
        self.registrationMap.addTypeMap(CMContainerClassRegistrationMap(returnedClass: returnedClass, replacedClass: replacedClass))
    }

    public func registerClassAsProtocol(t: AnyClass, p: Protocol) {
        self.registrationMap.addProtocolMap(CMContainerProtocolRegistrationMap(returnedClass: t, forProtocol: p))
    }

    public func autoregister() {
        let autoregClasses = CMBundleIntrospector().classesThatConformToProtocol(CMContainerAutoRegister.self)

        for p in autoregClasses {
            let c = p as! CMContainerAutoRegister.Type
            let cache = c.cache?() ?? false
            let onCreate = c.onCreate?()

            if (onCreate == nil) {
                self.registerClass(c, cache: cache)
            }
            else {
                self.registerClass(c, cache: cache, onCreate: onCreate!)
            }
        }
    }

    //*********
    // Storage
    //*********

    public func put(obj: AnyObject) {
        self.put(obj, asType: obj.dynamicType)
    }

    public func put(object: AnyObject, asType: AnyClass) {
        if (!self.registrationMap.isTypeRegistered(asType)) {
            self.registerClass(asType)
        }

        self.cache[asType] = object
    }

    public func put(object: AnyObject, p: Protocol) {
        let type: AnyClass = self.registrationMap.isProtocolRegistered(p) ? self.registrationMap.registrationForProtocol(p)!.returnedClass : object.dynamicType

        self.put(object, asType: type)
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

    public func objectForType<T:NSObject>() -> T {
        return self.objectForType(T.self) as! T
    }

    public func objectForProtocol(p: Protocol) -> NSObject? {
        let reg = self.registrationMap.registrationForProtocol(p)

        return reg == nil ? nil : self.objectForType(reg!.returnedClass)
    }

    public func objectForType(t: AnyClass) -> NSObject {
        let reg = self.registrationMap.registrationForType(t)

        // if we already have a cached value then we should return that
        if (reg != nil && self.cache.hasType(reg!.type)) {
            return self.cache[reg!.type] as! NSObject
        }

        // create the object
        let obj = create((reg == nil ? CMTypeIntrospector(t: t) : reg!.typeIntrospector))

        // follow registration instructions if they exist
        if (reg != nil) {
            if (reg!.onCreate != nil) {
                reg!.onCreate!(obj)
            }

            if (reg!.cache) {
                self.put(obj, asType: reg!.type)
            }
        }

        // return
        return obj
    }

    public func inject(obj: NSObject) {
        self.inject(obj, asType: obj.dynamicType)
    }

    public func inject(obj: NSObject, asType: AnyClass) {
        let reg = self.registrationMap.registrationForType(asType)
        let introspector = (reg == nil ? CMTypeIntrospector(t: asType) : reg!.typeIntrospector)

        self.injectProperties(introspector, obj: obj)
    }

    private func create(introspector: CMTypeIntrospector) -> NSObject {
        let type = introspector.type as! NSObject.Type
        let obj = type.init()

        injectProperties(introspector, obj: obj)

        return obj
    }

    private func injectProperties(introspector: CMTypeIntrospector, obj: NSObject) {
        for prop in introspector.properties().filter({ !($0.typeInfo.isValueType) }) {
            guard let propObj = prop.typeInfo.isProtocol ? self.createInjectedValueForProtocol(prop.typeInfo.name) : self.createInjectedValueForClass(prop.typeInfo.name) else {
                continue
            }

            obj.setValue(propObj, forKey: prop.name)
        }
    }

    private func createInjectedValueForClass(name: String) -> NSObject? {
        let type: AnyClass = NSClassFromString(name)!
        let reg = self.registrationMap.registrationForType(type)

        return reg == nil ? nil : self.objectForType(type)
    }

    private func createInjectedValueForProtocol(name: String) -> NSObject? {
        let p: Protocol = NSProtocolFromString(name)!
        return self.objectForProtocol(p)
    }
}