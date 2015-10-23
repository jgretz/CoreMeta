//
// Created by Joshua Gretz on 10/16/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import XCTest

class CMTypeIntrospectorTests: XCTestCase {
    var properties: Array<CMPropertyInfo>!

    override func setUp() {
        let introspector = CMTypeIntrospector(t: FruitTree.self)

        properties = introspector.properties();
    }

    func testTreeShouldReturnSomeProperties() {
        XCTAssert(properties.count > 0, "Type Introspector: No properties found for tree")
    }

    func testTreeShouldReturnPropertyFruit() {
        XCTAssert(properties.any({($0 as CMPropertyInfo).name == "fruit"}), "Type Introspector: fruit property not found for tree")
    }

    func testTreeShouldReturnPropertyFruitOfTypeArray() {
        let propertyInfo = properties.first({($0 as CMPropertyInfo).name == "fruit"})!;

        XCTAssert(propertyInfo.typeInfo.name == "NSArray", "Type Introspector: fruit property not of type NSArray")
    }

    func testTreeShouldReturnPropertyColor() {
        XCTAssert(properties.any({($0 as CMPropertyInfo).name == "color"}), "Type Introspector: color property found for tree")
    }

    func testTreeShouldReturnPropertyColorOfTypeString() {
        let propertyInfo = properties.first({($0 as CMPropertyInfo).name == "color"})!;

        XCTAssert(propertyInfo.typeInfo.name == "NSString", "Type Introspector: color property not of type NSString")
    }
}