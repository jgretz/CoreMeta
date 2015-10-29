//
// Created by Joshua Gretz on 10/28/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import XCTest

class CMBundleIntrospectorTests : XCTestCase {
    var intropector:CMBundleIntrospector!

    override func setUp() {
        intropector = CMBundleIntrospector()
    }

    func testIntrospectorShouldReturnAnEmptyArrayIfNoClassesConformToProtocol() {
        let classes = intropector.classesThatConformToProtocol(Lizard.self)

        XCTAssert(classes.count == 0, "Bundle Introspector: returning classes for a protocol none implement")
    }

    func testIntrospectorShouldReturnClassesForEachClassThatConformsToProtocol() {
        let classes = intropector.classesThatConformToProtocol(Fish.self)

        XCTAssert(classes.count > 0, "Bundle Introspector: returning no classes for a protocol classes implement")
    }
}
