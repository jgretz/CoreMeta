//
// Created by Joshua Gretz on 10/23/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import XCTest

class CMContainerCacheTests : XCTestCase {
    var cache: CMContainerCache!

    override func setUp() {
        self.cache = CMContainerCache()
    }

    func testCacheShouldReturnNilForUnsetKey() {
        XCTAssertNil(self.cache[Flower.self], "Container Cache: cache returning value for unset key")
    }

    func testCacheShouldReturnObjectSetForKey() {
        let tree = Tree()
        self.cache[Tree.self] = tree

        let val = self.cache[Tree.self]

        XCTAssert(val != nil && (val as! Tree) == tree, "Container Cache: cache not returning set value for key")
    }

    func testCacheHasTypeShouldReturnWhenObjectIsSetForKey() {
        self.cache[Tree.self] = Tree()

        XCTAssert(self.cache.hasType(Tree.self), "Container Cache: Has Type returning false for set key")
    }

    func testCacheShouldRetainNoItemsWhenCleared() {
        self.cache[Tree.self] = Tree()
        self.cache.clear()

        XCTAssert(self.cache.cache.count == 0, "Container Cache: cache still has values after being cleared")
    }

    func testCacheShouldRetainNoValueForKeyCleared() {
        self.cache[Tree.self] = Tree()
        self.cache[Flower.self] = Flower()

        self.cache.clear(Tree.self)

        XCTAssert(self.cache.cache.count == 1, "Container Cache: cache has incorrect number of values after type is cleared")
        XCTAssertNil(self.cache[Tree.self], "Container Cache: cache not removing value when type is cleared")
    }
}
