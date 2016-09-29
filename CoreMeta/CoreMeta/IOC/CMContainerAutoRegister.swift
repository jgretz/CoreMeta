//
// Created by Joshua Gretz on 10/28/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

@objc public protocol CMContainerAutoRegister : NSObjectProtocol {
    @objc optional static func cache() -> Bool
    @objc optional static func onCreate() -> (NSObject) -> Void
}
