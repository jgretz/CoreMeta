//
// Created by Joshua Gretz on 10/19/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

open class CMTypeInfo {
    open let name:String
    open let isKnown:Bool
    open let isValueType:Bool
    open let isProtocol:Bool

    init(name: String, isKnown:Bool, isValueType: Bool, isProtocol: Bool) {
        self.name = name
        self.isKnown = isKnown
        self.isValueType = isValueType
        self.isProtocol = isProtocol
    }
}
