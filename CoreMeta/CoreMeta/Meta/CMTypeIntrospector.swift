//
// Created by Joshua Gretz on 10/19/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public class CMTypeIntrospector {
    let type: AnyClass
    let valueTypeMap: Dictionary<String, String>

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

    public func properties() -> Array<CMPropertyInfo> {
        // get properties for this class
        var count = UInt32()
        let properties:UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(type, &count)

        var propertyInfos = Array<CMPropertyInfo>()
        for (var i = 0; i < Int(count); i++) {
            let property:objc_property_t = properties[i]

            guard let propertyName = NSString(UTF8String: property_getName(property)) as? String else {
                debugPrint("Couldn't unwrap property name for \(property)")
                continue
            }

            guard let infoString = NSString(UTF8String: property_getAttributes(property)) as? String else {
                debugPrint("Couldn't get property attributes for \(property)")
                continue
            }

            let infoParts = infoString.componentsSeparatedByString(",")
            let typeInfo = parseTypeInfo(infoParts.first!)

            propertyInfos.append(CMPropertyInfo(name: propertyName, typeInfo: typeInfo))
        }

        free(properties)

        // climb chain
        let superClass:AnyClass = class_getSuperclass(type)
        if (superClass != NSObject.self) {
            propertyInfos.appendContentsOf(CMTypeIntrospector(t: superClass).properties())
        }

        // return
        return propertyInfos
    }

    private func parseTypeInfo(typename: String) -> CMTypeInfo {
        return isValueType(typename) ? parseValueTypeInfo(typename)
                : isProtocol(typename) ? parseProtocolInfo(typename)
                : parseRefTypeInfo(typename)
    }

    private func parseValueTypeInfo(typename: String) -> CMTypeInfo {
        let key = typename.substringToIndex(typename.startIndex.advancedBy(2))
        let name = valueTypeMap[key]!

        return CMTypeInfo(name: name, isValueType: true, isProtocol: false)
    }

    private func parseProtocolInfo(typename: String) -> CMTypeInfo {
        let name = typename.substringWithRange(Range(start: typename.startIndex.advancedBy(4), end: typename.endIndex.advancedBy(-2)))

        return CMTypeInfo(name: name, isValueType: false, isProtocol: true)
    }

    private func parseRefTypeInfo(typename: String) -> CMTypeInfo {
        let name = typename.substringWithRange(Range(start: typename.startIndex.advancedBy(3), end: typename.endIndex.advancedBy(-1)));

        return CMTypeInfo(name: name, isValueType: false, isProtocol: false)
    }

    private func isValueType(typename: String) -> Bool {
        return !typename.hasPrefix("T@")
    }

    private func isProtocol(typename: String) -> Bool {
        return typename.substringFromIndex(typename.startIndex.advancedBy(3)).hasPrefix("<")
    }
}
