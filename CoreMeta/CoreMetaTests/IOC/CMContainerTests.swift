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
    var shark: Shark!

    override func setUp() {
        self.tree = Tree()
        self.rose = Rose()
        self.leaf = Leaf()
        self.trout = Trout()
        self.shark = Shark()

        container = CMContainer()

        container.registerClass(Leaf.self, cache: true)
        container.registerClassAsClass(Rose.self, replacedClass: Flower.self)

        container.registerClassAsProtocol(Trout.self, p: Fish.self)
        container.registerClass(Shark.self, cache: false, onCreate: { ($0 as! Shark).name = "Jaws" })

        container.autoregister()
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

    func testContainerShouldReturnedCachedObjectIfSpecified() {
        let obj1:Leaf = container.objectForType()
        let obj2:Leaf = container.objectForType()

        XCTAssert(obj1 == obj2, "Container: not caching class defined as cache = true")
    }

    func testContainerShouldExecuteOnCreateIfSpecified() {
        let obj1:Shark = container.objectForType()

        XCTAssert(obj1.name == "Jaws", "Container: not calling onCreate as specified")
    }

    func testContainerShouldReturnClassThatFollowsAutoRegistration() {
        let obj1:Pizza = container.objectForType()
        let obj2:Pizza = container.objectForType()

        XCTAssert(obj1 == obj2, "Container: not caching object per auto-registration")
        XCTAssert(obj1.name != nil && obj1.name == "Pep" , "Container: not executing onCreate object per auto-registration")
    }

    func testContainerShouldAutoRegisterItself() {
        let con:CMContainer = container.objectForType()

        XCTAssert(con == container, "Container: container not auto registering itself as cache: true")
    }

    func testContainerShouldAutoRegisterItselfAsCMContainerProtocol() {
        let con = container.objectForProtocol(CMContainerProtocol.self)

        XCTAssert(con != nil, "Container: container not auto registering itself as a CMContainerProtocol")
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

    //***********
    // Injection
    //***********

    func testContainerShouldAssignValuesForPropertiesForRegisteredClasses() {
        let obj:Ocean = container.objectForType()

        XCTAssertNotNil(obj.shark, "Container: is not assigning a value for property of a class type that is registered")
    }

    func testContainerShouldAssignValuesForPropertiesForRegisteredProtocols() {
        let obj:Ocean = container.objectForType()

        XCTAssertNotNil(obj.fish, "Container: is not assigning a value for a property of a protocol type that is registered")
    }

    func testContainerShouldAssignValuesStoredForPropertiesForRegisteredClasses() {
        container.put(self.shark)

        let obj:Ocean = container.objectForType()
        XCTAssertEqual(obj.shark, self.shark, "Container: is not assigning put value for a property of a class type")
    }

    func testContainerShouldAssignValuesStoredForPropertiesForRegisteredProtocols() {
        container.put(self.trout, p: Fish.self)

        let obj:Ocean = container.objectForType()
        XCTAssertEqual(obj.fish as? Trout, self.trout, "Container: is not assigning put value for a property of a protocol type")
    }

    func testContainerShouldNotAssignValueToPropertyThatIsNotRegistered() {
        let obj:Ocean = container.objectForType()

        XCTAssertNil(obj.whale, "Container: is assigning a value for a property that is not registered")
    }

    func testContainerShouldInjectObjectWithPropertiesAsIfItWasCreated() {
        let obj = Ocean()
        container.inject(obj)

        XCTAssertNotNil(obj.shark, "Container: is not assigning a value for property of a class type that is registered on injection")
    }
}
