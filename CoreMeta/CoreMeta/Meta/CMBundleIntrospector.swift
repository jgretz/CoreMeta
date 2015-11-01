//
// Created by Joshua Gretz on 10/28/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public class CMBundleIntrospector {
    public init() {
    }

    public func classesThatConformToProtocol(p: Protocol) -> Array<NSObject.Type> {
        var result = Array<NSObject.Type>()

        var numClasses = objc_getClassList(nil, 0)
        let classes = AutoreleasingUnsafeMutablePointer<AnyClass?>(malloc(Int(sizeof(AnyClass) * Int(numClasses))))
        numClasses = objc_getClassList(classes, numClasses)

        for (var i = 0; i < Int(numClasses); i++) {
            let c:AnyClass! = classes[i] as AnyClass!

            if (class_conformsToProtocol(c, p)) {
                result.append(c as! NSObject.Type)
            }
        }

        return result
    }
}
