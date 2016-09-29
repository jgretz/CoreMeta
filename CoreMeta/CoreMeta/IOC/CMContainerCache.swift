//
// Created by Joshua Gretz on 10/23/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

class CMContainerCache {
    var cache: Dictionary<String, AnyObject>

    init() {
        self.cache = Dictionary<String, AnyObject>()
    }

    subscript(type: AnyClass) -> AnyObject? {
        get {
            return self.objectForClass(type)
        }

        set(newValue) {
            self.put(newValue!, type: type)
        }
    }

    func hasType(_ type: AnyClass) -> Bool {
        return self.cache.hasKey(keyFromType(type))
    }

    func put(_ obj: AnyObject, type: AnyClass) {
        self.cache[keyFromType(type)] = obj
    }

    func objectForClass(_ type: AnyClass) -> AnyObject? {
        return self.cache[keyFromType(type)]
    }

    func clear() {
        self.cache.removeAll()
    }

    func clear(_ type: AnyClass) {
        self.cache.removeValue(forKey: keyFromType(type))
    }

    fileprivate func keyFromType(_ type: AnyClass) -> String {
        return NSStringFromClass(type)
    }

}
