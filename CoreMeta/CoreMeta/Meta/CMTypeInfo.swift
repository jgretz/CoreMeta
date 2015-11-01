//
// Created by Joshua Gretz on 10/19/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public class CMTypeInfo {
    public let name:String
    public let isKnown:Bool
    public let isValueType:Bool
    public let isProtocol:Bool

    init(name: String, isKnown:Bool, isValueType: Bool, isProtocol: Bool) {
        self.name = name
        self.isKnown = isKnown
        self.isValueType = isValueType
        self.isProtocol = isProtocol
    }
}
