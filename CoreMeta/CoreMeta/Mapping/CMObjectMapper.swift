//
// Created by Joshua Gretz on 10/29/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

open class CMObjectMapper {
    fileprivate var mappings:Dictionary<String,CMObjectMap>

    public init() {
        mappings = Dictionary<String,CMObjectMap>()
    }

    //**************
    // Registration
    //**************

    open func registerMap(_ source: AnyClass, target: AnyClass) {
        self.registerMap(source, target: target, map: CMObjectMap.self)
    }

    open func registerMap(_ source: AnyClass, target: AnyClass, map: AnyClass) {
        let instance = (map as! CMObjectMap.Type).init()
        instance.createDefaultMap(source, target: target)

        mappings[mapKey(source, target: target)] = instance
    }

    fileprivate func mapKey(_ source: AnyClass, target: AnyClass) -> String {
        return "\(NSStringFromClass(source))_\(NSStringFromClass(target))"
    }

    //************
    // Map Object
    //************

    open func map(_ source:NSObject, target:NSObject) {
        let key = mapKey(type(of: source), target: type(of: target))
        if (!mappings.hasKey(key)) {
            self.registerMap(type(of: source), target: type(of: target))
        }

        self.map(source, target: target, map: mappings[key]!)
    }

    open func map(_ source:NSObject, target:NSObject, map:CMObjectMap) {
        let targetProperties = CMTypeIntrospector(t:type(of: target)).properties()
        for property in targetProperties {
            map.mapValueFromSourceToTargetForProperty(source, target: target, propertyName: property.name)
        }
    }
}
