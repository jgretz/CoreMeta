//
// Created by Joshua Gretz on 10/20/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

public extension Array {
    func first(@noescape f: (Array.Generator.Element) -> Bool) -> Array.Generator.Element? {
        return self.filter(f).first
    }

    func any(@noescape f: (Array.Generator.Element) -> Bool) -> Bool {
        return self.filter(f).count > 0
    }

    func all(@noescape f: (Array.Generator.Element) -> Bool) -> Bool {
        return self.filter(f).count == self.count
    }
}
