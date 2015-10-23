//
// Created by Joshua Gretz on 10/23/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

class CMContainerProtocolRegistrationMap {
    let returnedClass: AnyClass
    let forProtocol: Protocol

    init(returnedClass: AnyClass, forProtocol: Protocol) {
        self.returnedClass = returnedClass
        self.forProtocol = forProtocol
    }
}
