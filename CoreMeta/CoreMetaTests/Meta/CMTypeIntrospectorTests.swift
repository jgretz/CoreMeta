//
// Created by Joshua Gretz on 10/16/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import XCTest
import CoreMeta

class CMTypeIntrospectorTests: XCTestCase {

    class Tree: NSObject {
        var fruit: Array<Fruit>
        var color: String

        init(fruit: Array<Fruit>, color: String) {
            self.fruit = fruit
            self.color = color
        }

    }

    class Fruit: NSObject {
        var name: String

        init(name: String) {
            self.name = name
        }
    }

    // tests
    var properties: Array<CMPropertyInfo>!

    override func setUp() {
        let introspector = CMTypeIntrospector<Tree>()

        properties = introspector.properties();
    }

    func testTreeShouldReturnSomeProperties() {
        XCTAssert(properties.count > 0, "No properties found for tree")
    }

    func testTreeShouldReturnPropertyFruit() {
        XCTAssert(properties.any({($0 as CMPropertyInfo).name == "fruit"}), "fruit property not found for tree")
    }

    func testTreeShouldReturnPrpertyColor() {
        XCTAssert(properties.any({($0 as CMPropertyInfo).name == "color"}), "color property found for tree")
    }
}