//
// Created by Joshua Gretz on 10/21/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

class CMContainerClassRegistrationMap {
    let returnedClass: AnyClass
    let replacedClass: AnyClass

    init(returnedClass: AnyClass, replacedClass: AnyClass) {
        self.returnedClass = returnedClass
        self.replacedClass = replacedClass
    }
}
