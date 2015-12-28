//
// Created by Joshua Gretz on 10/20/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public class CMContainer : NSObject, CMContainerProtocol {
    var registrationMap: CMContainerRegistrationMap
    var cache: CMContainerCache

    public override init() {
        self.registrationMap = CMContainerRegistrationMap()
        self.cache = CMContainerCache()

        super.init()

        self.registerClass(CMContainer.self, cache: true)
        self.registerClassAsProtocol(CMContainer.self, p: CMContainerProtocol.self)
        self.put(self)
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
        let properties = introspector.properties()
        for prop in properties.filter({ !($0.typeInfo.isValueType || !$0.typeInfo.isKnown) }) {
            guard let propObj = prop.typeInfo.isProtocol ? self.createInjectedValueForProtocol(prop.typeInfo.name) : self.createInjectedValueForClass(prop.typeInfo.name) else {
                continue
            }

            obj.setValue(propObj, forKey: prop.name)
        }
        
        injectClosures(obj, properties: properties)
    }
    
    private func injectClosures(obj: NSObject, properties: [CMPropertyInfo]) {
        let mirror = Mirror(reflecting: obj)
        for child in mirror.children.filter({ c in nil != properties.first({p in p.name == c.label})}) {
            if let lamdaReturnTypeName = getClosureReturnTypeName(child.value.dynamicType) {
                let generator = convertClosureToObjcBlock({ self.objectForTypeName(lamdaReturnTypeName)! })
                obj.setValue(generator, forKey: child.label!)
            }
        }
    }
    
    private func getClosureReturnTypeName(type: Any.Type) -> String? {
        
        // String(reflecting:) gets the type names with the full name space
        let typeString = String(reflecting: type)

        // Captures a type name from statements like
        // "Swift.Optional<() -> Swift.String>" and "() -> Swift.String"
        let regex = try! NSRegularExpression(pattern: "(?:Swift.Optional\\<)?\\(\\) -> ([^>]*)(?:\\>)?", options: NSRegularExpressionOptions(rawValue: 0))
        
        let matches = regex.matchesInString(typeString, options: .WithTransparentBounds, range: NSMakeRange(0, typeString.characters.count))
        if let match = matches.first {
            let range = match.rangeAtIndex(1)
            return (typeString as NSString).substringWithRange(range)
        }
        
        return nil
    }
    
    private func convertClosureToObjcBlock(closure: () -> NSObject) -> AnyObject {
        let objcBlock:@convention(block) () -> NSObject = closure
        return unsafeBitCast(objcBlock, AnyObject.self)
    }
    
    private func objectForTypeName(typeName : String) -> NSObject? {
        
        if let tClass = NSClassFromString(typeName) {
            return objectForType(tClass)
        }
        
        if let tProtocol = NSProtocolFromString(typeName) {
            return objectForProtocol(tProtocol)
        }
        
        return nil
    }
    

    private func createInjectedValueForClass(name: String) -> NSObject? {
        let type:AnyClass? = NSClassFromString(name)
        if (type == nil) {
            return nil
        }
        
        let reg = self.registrationMap.registrationForType(type!)
        return reg == nil ? nil : self.objectForType(type!)
    }

    private func createInjectedValueForProtocol(name: String) -> NSObject? {
        let p:Protocol? = NSProtocolFromString(name)
        if (p == nil) {
            return nil
        }
        
        return self.objectForProtocol(p!)
    }
}