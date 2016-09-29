//
// Created by Joshua Gretz on 10/20/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public extension Array {
    public func first(_ f: (Array.Iterator.Element) -> Bool) -> Array.Iterator.Element? {
        return self.filter(f).first
    }

    public func any(_ f: (Array.Iterator.Element) -> Bool) -> Bool {
        return self.filter(f).count > 0
    }

    public func all(_ f: (Array.Iterator.Element) -> Bool) -> Bool {
        return self.filter(f).count == self.count
    }
}
