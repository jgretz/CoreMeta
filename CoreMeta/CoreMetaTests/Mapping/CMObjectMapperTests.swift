//
// Created by Joshua Gretz on 10/29/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import XCTest

class CMObjectMapperTests : XCTestCase {
    var source:Cake!
    var target:Cake!

    override func setUp() {
        source = Cake(flavor: "chocolate", color: "brown", icing: true, filling: nil)
        target = Cake()
    }

    func testPropertiesShouldCopyOverFromSourceToTarget() {
        CMObjectMapper().map(source, target: target)

        XCTAssert(source.flavor == target.flavor, "Object Mapper: target property does not equal source property")
        XCTAssert(source.color == target.color, "Object Mapper: target property does not equal source property")
        XCTAssert(source.icing == target.icing, "Object Mapper: target property does not equal source property")
        XCTAssert(source.filling == target.filling, "Object Mapper: target property does not equal source property")
    }
}