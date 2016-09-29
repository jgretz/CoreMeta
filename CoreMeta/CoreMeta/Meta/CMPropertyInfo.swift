//
// Created by Joshua Gretz on 10/19/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

open class CMPropertyInfo {
    open let name: String
    open let typeInfo: CMTypeInfo

    init(name: String, typeInfo: CMTypeInfo) {
        self.name = name
        self.typeInfo = typeInfo
    }
}
