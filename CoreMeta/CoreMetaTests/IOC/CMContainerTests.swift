//
// Created by Joshua Gretz on 10/20/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import XCTest

class CMContainerTests : XCTestCase {
    var container: CMContainer!
    var tree: Tree!
    var rose: Rose!
    var leaf: Leaf!
    var trout: Trout!

    override func setUp() {
        self.tree = Tree()
        rose = Rose()
        leaf = Leaf()
        trout = Trout()

        container = CMContainer()

        container.registerClass(Leaf.self, cache: true)
        container.registerClassAsClass(Rose.self, replacedClass: Flower.self)

        container.registerClassAsProtocol(Trout.self, p: Fish.self)
    }

    //**********
    // Creation
    //**********

    func testContainerShouldReturnObjectOfTypeRequested() {
        let obj = container.objectForType(Tree.self)

        XCTAssert(obj.dynamicType == Tree.self , "Container: does not return type requested")
    }

    func testContainerShouldReturnMappedTypeIfSpecified() {
        let obj = container.objectForType(Flower.self)

        XCTAssert(obj.dynamicType == Rose.self , "Container: does not return mapped type for class requested")
    }

    func testContainerShouldReturnObjectOfTypeSpecifiedForMappedProtocol() {
        let obj = container.objectForProtocol(Fish.self)

        XCTAssert(obj != nil && obj!.dynamicType == Trout.self, "Container: does not return mapped type for protocol requested")
    }

    func testContainerShouldReturnNilForUnmappedProtocol() {
        XCTAssertNil(container.objectForProtocol(Lizard.self), "Container: returns a value for unmapped protocol")
    }

    //*********
    // Storage
    //*********

    func testContainerShouldRegisterTypeForPutObject() {
        container.put(self.tree)
        let obj = container.objectForType(Tree.self)

        XCTAssert(self.tree == obj, "Container: does not automatically register type on put object")
    }

    func testContainerShouldNotOverwriteExistingRegistrationWhenPuttingObject() {
        container.put(self.leaf)
        let reg = container.registrationMap.registrationForType(Leaf.self)

        XCTAssert(reg!.cache, "Container: overwriting previous registration of type on put object")
    }

    func testContainerShouldReturnPutObjectForType() {
        container.put(self.rose)
        let obj = container.objectForType(Rose.self)

        XCTAssert(rose == obj, "Container: does not return object put into container for type")
    }

    func testContainerShouldReturnPutObjectForMappedType() {
        container.put(self.rose)
        let obj = container.objectForType(Flower.self)

        XCTAssert(rose == obj, "Container: does not return object put into container for mapped type")
    }

    func testContainerShouldRemoveAllObjectsWhenCleared() {
        container.put(rose)
        container.put(tree)
        container.clear()

        XCTAssert(container.objectForType(Rose.self) != self.rose, "Container: does not remove all objects when clear is called, rose found")
        XCTAssert(container.objectForType(Tree.self) != self.tree, "Container: does not remove all objects when clear is called, tree found")
    }

    func testContainerShouldRemoveObjectWhenClearedForClass() {
        container.put(rose)
        container.clearClass(Rose.self)

        XCTAssert(container.objectForType(Rose.self) != self.rose, "Container: does not remove object when clear for type is called")
    }

    func testContainerShouldRemoveOnlySpecifiedObjectWhenClearForClass() {
        container.put(tree)
        container.clearClass(Rose.self)

        XCTAssert(container.objectForType(Tree.self) == self.tree, "Container: is removing incorrect object when clear for type is called")
    }

    func testContainerShouldReturnPutObjectForMappedProtocol() {
        container.put(self.trout, p: Fish.self)

        XCTAssert(container.objectForProtocol(Fish.self) == self.trout, "Container: does not return object put into container for mapped protocol")
    }

    func testContainerShouldRemoveObjectWhenClearedForProtocol() {
        container.put(self.trout, p: Fish.self)
        container.clearProtocol(Fish.self)

        XCTAssert(container.objectForProtocol(Fish.self) != self.trout, "Container: does not remove object when clear for protocol is called")
    }

    func testContainerShouldRemoveOnlySpecifiedObjectWhenClearForProtocol() {
        container.put(tree)
        container.clearProtocol(Fish.self)

        XCTAssert(container.objectForType(Tree.self) == self.tree, "Container: is removing incorrect object when clear for protocol is called")
    }
}
