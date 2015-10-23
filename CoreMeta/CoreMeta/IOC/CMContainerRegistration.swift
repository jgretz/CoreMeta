//
// Created by Joshua Gretz on 10/20/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

class CMContainerClassRegistration {
    let type: AnyClass
    let typeIntrospector: CMTypeIntrospector
    let cache: Bool

    var onCreate: ((NSObject) -> Void)?

    init(type: AnyClass, cache: Bool, onCreate: ((NSObject) -> Void)?) {
        self.type = type
        self.cache = cache
        self.onCreate = onCreate
        self.typeIntrospector = CMTypeIntrospector(t: type)
    }
}
