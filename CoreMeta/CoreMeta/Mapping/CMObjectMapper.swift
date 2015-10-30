//
// Created by Joshua Gretz on 10/29/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public class CMObjectMapper {
    private var mappings:Dictionary<String,CMObjectMap>

    init() {
        mappings = Dictionary<String,CMObjectMap>()
    }

    //**************
    // Registration
    //**************

    func registerMap(source: AnyClass, target: AnyClass) {
        self.registerMap(source, target: target, map: CMObjectMap.self)
    }

    func registerMap(source: AnyClass, target: AnyClass, map: AnyClass) {
        let instance = (map as! CMObjectMap.Type).init()
        instance.createDefaultMap(source, target: target)

        mappings[mapKey(source, target: target)] = instance
    }

    private func mapKey(source: AnyClass, target: AnyClass) -> String {
        return "\(NSStringFromClass(source))_\(NSStringFromClass(target))"
    }

    //************
    // Map Object
    //************

    func map(source:NSObject, target:NSObject) {
        let key = mapKey(source.dynamicType, target: target.dynamicType)
        if (!mappings.hasKey(key)) {
            self.registerMap(source.dynamicType, target: target.dynamicType)
        }

        self.map(source, target: target, map: mappings[key]!)
    }

    func map(source:NSObject, target:NSObject, map:CMObjectMap) {
        let targetProperties = CMTypeIntrospector(t:target.dynamicType).properties()
        for property in targetProperties {
            map.mapValueFromSourceToTargetForProperty(source, target: target, propertyName: property.name)
        }
    }
}