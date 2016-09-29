//
// Created by Joshua Gretz on 10/21/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public extension Dictionary {
    public func hasKey(_ key: Key) -> Bool {
        return self[key] != nil
    }
}
