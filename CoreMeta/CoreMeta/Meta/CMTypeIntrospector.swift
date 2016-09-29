//
// Created by Joshua Gretz on 10/19/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

open class CMTypeIntrospector {
    let type:AnyClass
    let valueTypeMap:Dictionary<String, String>

    public init(t: AnyClass) {
        self.type = t

        valueTypeMap = [
                "Tf": "float",
                "Ti": "int",
                "Tc": "char",
                "Td": "double",
                "Tl": "long",
                "Ts": "short",
                "TB": "bool"
        ]
    }

    open func properties() -> Array<CMPropertyInfo> {
        // get properties for this class
        var count = UInt32()
        let properties:UnsafeMutablePointer<objc_property_t?>! = class_copyPropertyList(type, &count)

        var propertyInfos = Array<CMPropertyInfo>()
        for i in 0..<Int(count) {
            let property:objc_property_t = properties[i]!

            guard let propertyName = NSString(utf8String: property_getName(property)) as? String else {
                debugPrint("Couldn't unwrap property name for \(property)")
                continue
            }

            guard let infoString = NSString(utf8String: property_getAttributes(property)) as? String else {
                debugPrint("Couldn't get property attributes for \(property)")
                continue
            }

            let infoParts = infoString.components(separatedBy: ",")
            let typeInfo = parseTypeInfo(infoParts.first!)

            propertyInfos.append(CMPropertyInfo(name: propertyName, typeInfo: typeInfo))
        }

        free(properties)

        // climb chain
        let superClass:AnyClass = class_getSuperclass(type)
        if (superClass != NSObject.self) {
            propertyInfos.append(contentsOf: CMTypeIntrospector(t: superClass).properties())
        }

        // return
        return propertyInfos
    }

    fileprivate func parseTypeInfo(_ typename: String) -> CMTypeInfo {
        return !isKnown(typename) ? parseUnknown(typename)
                : isValueType(typename) ? parseValueTypeInfo(typename)
                : isProtocol(typename) ? parseProtocolInfo(typename)
                : parseRefTypeInfo(typename)
    }
    
    fileprivate func parseUnknown(_ typename:String) -> CMTypeInfo {
        return CMTypeInfo(name: typename, isKnown: false, isValueType: false, isProtocol: false)
    }

    fileprivate func parseValueTypeInfo(_ typename: String) -> CMTypeInfo {
        let key = typename.substring(to: typename.characters.index(typename.startIndex, offsetBy: 2))
        let name = valueTypeMap[key]!

        return CMTypeInfo(name: name, isKnown: true, isValueType: true, isProtocol: false)
    }

    fileprivate func parseProtocolInfo(_ typename: String) -> CMTypeInfo {
        let name = typename.substring(with: (typename.characters.index(typename.startIndex, offsetBy: 4) ..< typename.characters.index(typename.endIndex, offsetBy: -2)))

        return CMTypeInfo(name: name, isKnown: true, isValueType: false, isProtocol: true)
    }

    fileprivate func parseRefTypeInfo(_ typename: String) -> CMTypeInfo {
        guard typename.characters.count > 3
            else { return CMTypeInfo(name: typename, isKnown: false, isValueType: false, isProtocol: false) }
        
        let name = typename.substring(with: (typename.characters.index(typename.startIndex, offsetBy: 3) ..< typename.characters.index(typename.endIndex, offsetBy: -1)));

        return CMTypeInfo(name: name, isKnown: true, isValueType: false, isProtocol: false)
    }
    
    fileprivate func isKnown(_ typename:String) -> Bool {
        if (typename == "T@?") {
            return false
        }
        
        if (typename.hasPrefix("T@")) {
            return true
        }
        
        if (valueTypeMap.hasKey(typename)) {
            return true
        }
        
        return false
    }

    fileprivate func isValueType(_ typename: String) -> Bool {
        return !typename.hasPrefix("T@")
    }

    fileprivate func isProtocol(_ typename: String) -> Bool {
        return typename.characters.count > 3 && typename.substring(from: typename.characters.index(typename.startIndex, offsetBy: 3)).hasPrefix("<")
    }
}
