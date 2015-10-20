//
// Created by Joshua Gretz on 10/19/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public class CMPropertyInfo {
    public let name: String
    public let typeInfo: CMTypeInfo
    public let isReadOnly: Bool

    init(name: String, typeInfo: CMTypeInfo, isReadOnly: Bool) {
        self.name = name
        self.typeInfo = typeInfo
        self.isReadOnly = isReadOnly
    }
}
