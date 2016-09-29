//
// Created by Joshua Gretz on 10/29/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

open class CMObjectMap {
    var ignoreValue:((String,AnyObject?) -> Bool)?
    var propertyMap:Dictionary<String,(String,NSObject?)->AnyObject?>

    public required init () {
        propertyMap = Dictionary<String,(String,NSObject?)->AnyObject?>()
    }

    func createDefaultMap(_ source:AnyClass, target:AnyClass) {
        let sourceProperties = CMTypeIntrospector(t:source).properties()
        let targetProperties = CMTypeIntrospector(t:target).properties()

        for targetProperty in targetProperties {
            if (!sourceProperties.any({$0.name.uppercased() == targetProperty.name.uppercased()})) {
                continue
            }

            setPropertyMap(targetProperty.name, mapLogic: { (p:String,obj:NSObject?) -> AnyObject? in
                if (obj == nil) {
                    return nil
                }
                
                return obj!.value(forKey: p) as AnyObject?
            })
        }
    }

    func mapValueFromSourceToTargetForProperty(_ source:NSObject,target:NSObject,propertyName:String) {
        let value = self.valueForTargetProperty(propertyName,source:source)

        // allow ignore
        if (ignoreValue != nil && ignoreValue!(propertyName,value)) {
            return
        }

        // set
        target.setValue(value, forKey: propertyName)
    }

    func setPropertyMap(_ propertyName:String,mapLogic:@escaping (String,NSObject?)->AnyObject?) {
        propertyMap[propertyName] = mapLogic
    }

    func valueForTargetProperty(_ propertyName:String,source:NSObject) -> AnyObject? {
        if (!propertyMap.hasKey(propertyName)) {
            return nil
        }

        let logic = propertyMap[propertyName]!
        return logic(propertyName,source)
    }
}
