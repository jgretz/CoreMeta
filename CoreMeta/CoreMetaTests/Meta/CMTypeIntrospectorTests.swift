//
// Created by Joshua Gretz on 10/16/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import XCTest

class CMTypeIntrospectorTests: XCTestCase {
    var properties: Array<CMPropertyInfo>!

    override func setUp() {
        let introspector = CMTypeIntrospector(t: Ocean.self)

        properties = introspector.properties();
    }

    func testPropertiesShouldReturnSomePropertiesWhenClassHasProperties() {
        XCTAssert(properties.count > 0, "Type Introspector: No properties found for class")
    }

    func testPropertyShouldHaveFalseForAllBooleansIfNotApplicable() {
        guard let property = properties.first({$0.name == "shark"}) else {
            XCTFail("Type Introspector: defined property not found")
            return
        }

        XCTAssertFalse(property.typeInfo.isValueType, "Type Introspector: isValueType set to true for non-readonly property")
        XCTAssertFalse(property.typeInfo.isProtocol, "Type Introspector: isProtocol set to true for non-readonly property")
    }

    func testPropertyShouldBeValueTypeForValueTypeProperties() {
        guard let property = properties.first({$0.name == "depth"}) else {
            XCTFail("Type Introspector: defined property not found")
            return
        }

        XCTAssert(property.typeInfo.isValueType, "Type Introspector: isValueType set to false for value type property")
    }

    func testPropertyShouldBeProtocolForProtocolProperties() {
        guard let property = properties.first({$0.name == "fish"}) else {
            XCTFail("Type Introspector: defined property not found")
            return
        }

        XCTAssert(property.typeInfo.isProtocol, "Type Introspector: isProtocol set to false for protocol property")
    }
}