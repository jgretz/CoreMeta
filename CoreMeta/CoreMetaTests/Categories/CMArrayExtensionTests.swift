//
// Created by Joshua Gretz on 10/20/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import XCTest

class CMArrayExtensionTests : XCTestCase {
    var array: Array<Int>!

    override func setUp() {
        self.array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }

    func testFirstShouldReturnOneElement() {
        XCTAssert(self.array.first({ $0 == 1 }) == 1, "Array Extension: First not returning one single element")
    }

    func testAnyShouldReturnTrueIfAtLeastOneElementPasses() {
        XCTAssert(self.array.any({ $0 > 5 }), "Array Extension: Any does not return true when one element passes test")
    }

    func testAnyShouldReturnFalseIfNoElementPasses() {
        XCTAssertFalse(self.array.any({ $0 > 10 }), "Array Extension: Any does not return false when no element passes test")
    }

    func testAllShouldReturnTrueIfAllElementsPass() {
        XCTAssert(self.array.all({ $0 > 0 }), "Array Extension: All does not return true when all elements pass test")
    }

    func testAllShouldReturnFalseIfOneElementFails() {
        XCTAssertFalse(self.array.all({ $0 > 1 }), "Array Extension: All does not return false when one element fails test")
    }
}
