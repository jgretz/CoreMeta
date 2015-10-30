//
// Created by Joshua Gretz on 10/29/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public class CMObjectMap {
    var ignoreValue:((String,AnyObject?) -> Bool)?
    var propertyMap:Dictionary<String,(String,NSObject?)->AnyObject?>

    public required init () {
        propertyMap = Dictionary<String,(String,NSObject?)->AnyObject?>()
    }

    func createDefaultMap(source:AnyClass, target:AnyClass) {
        let sourceProperties = CMTypeIntrospector(t:source).properties()
        let targetProperties = CMTypeIntrospector(t:target).properties()

        for targetProperty in targetProperties {
            if (!sourceProperties.any({$0.name.uppercaseString == targetProperty.name.uppercaseString})) {
                continue
            }

            setPropertyMap(targetProperty.name, mapLogic: { (p:String,obj:NSObject?) -> AnyObject? in return obj == nil ? nil : obj!.valueForKey(p) })
        }
    }

    func mapValueFromSourceToTargetForProperty(source:NSObject,target:NSObject,propertyName:String) {
        let value = self.valueForTargetProperty(propertyName,source:source)

        // allow ignore
        if (ignoreValue != nil && ignoreValue!(propertyName,value)) {
            return
        }

        // set
        target.setValue(value, forKey: propertyName)
    }

    func setPropertyMap(propertyName:String,mapLogic:(String,NSObject?)->AnyObject?) {
        propertyMap[propertyName] = mapLogic
    }

    func valueForTargetProperty(propertyName:String,source:NSObject) -> AnyObject? {
        if (!propertyMap.hasKey(propertyName)) {
            return nil
        }

        let logic = propertyMap[propertyName]!
        return logic(propertyName,source)
    }
}
