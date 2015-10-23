//
// Created by Joshua Gretz on 10/21/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import XCTest

class CMDictionaryTests : XCTestCase {
    var dictionary: Dictionary<String, String>!

    override func setUp() {
        self.dictionary = [
            "Test": "Test",
            "Test1": "Test",
            "Test2": "Test",
            "Test3": "Test"
        ]
    }

    func testHasKeyShouldReturnTrueIfKeyIsInDictionary() {
        XCTAssert(dictionary.hasKey("Test"), "Dictionary Extension: hasKey is not returning true for a key that is in the dictionary")
    }

    func testHasKeyShouldReturnFalseIfKeyIsNotInDictionary() {
        XCTAssertFalse(dictionary.hasKey("Not there"), "Dictionary Extension: hasKey is returning true for a key that is not in the dictionary")
    }
}
