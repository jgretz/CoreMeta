//
// Created by Joshua Gretz on 10/21/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import XCTest

class CMContainerRegistrationMapTests : XCTestCase {
    var registrationMap: CMContainerRegistrationMap!

    override func setUp() {
        self.registrationMap = CMContainerRegistrationMap()

        self.registrationMap.addRegistration(CMContainerClassRegistration(type: Tree.self, cache: true, onCreate: nil))
        self.registrationMap.addRegistration(CMContainerClassRegistration(type: Rose.self, cache: true, onCreate: nil))
        self.registrationMap.addRegistration(CMContainerClassRegistration(type: Trout.self, cache: true, onCreate: nil))

        self.registrationMap.addTypeMap(CMContainerClassRegistrationMap(returnedClass: Rose.self, replacedClass: Flower.self))
        self.registrationMap.addProtocolMap(CMContainerProtocolRegistrationMap(returnedClass: Trout.self, forProtocol: Fish.self))
    }

    func testWhenAClassIsAddedIsRegisteredShouldReturnTrue() {
        XCTAssert(self.registrationMap.isTypeRegistered(Tree.self), "Registration Map: isRegistered is false for type that is registered")
    }

    func testWhenAClassIsNotAddedIsRegisteredShouldReturnFalse() {
        XCTAssertFalse(self.registrationMap.isTypeRegistered(Leaf.self), "Registration Map: isRegistered is true for type that is not registered")
    }

    func testWhenAClassIsRegisteredAsAClassTheRegisteredClassShouldAutomaticallyBeRegistered() {
        XCTAssert(self.registrationMap.isTypeRegistered(Rose.self), "Registration Map: Return class for class map is not automatically being registered")
    }

    func testWhenAClassIsRegisteredAsAClassTheRegisteredClassShouldNotOverrideExistingRegistration() {
        let reg = self.registrationMap.registrationForType(Rose.self)
        XCTAssert(reg!.cache, "Registration Map: Type Map is overriding existing registration")
    }

    func testWhenAskedForAReplacedClassReturnedClassShouldBeReturned() {
        let reg = self.registrationMap.registrationForType(Flower.self)
        XCTAssert(reg != nil && reg!.type == Rose.self, "Registration Map: Replacement mapped class is not being returned")
    }

    func testWhenAProtocolIsRegisteredIsRegisteredShouldReturnTrue() {
        XCTAssert(self.registrationMap.isProtocolRegistered(Fish.self), "Registration Map: isRegistered is false for protocol that is registered")
    }

    func testWhenAProtocolIsNotRegisteredIsRegisteredShouldReturnFalse() {
        XCTAssertFalse(self.registrationMap.isProtocolRegistered(Lizard.self as Protocol), "Registration Map: isRegistered is true for protocol that is not registered")
    }

    func testWhenAProtocolIsRegisteredTheReturnedClassShouldAutomaticallyBeRegistered() {
        XCTAssert(self.registrationMap.isTypeRegistered(Trout.self), "Registration Map: Return class for protocol is not automatically registered")
    }

    func testWhenAProtocolIsRegisteredTheRegisteredClassShouldNotOverrideExistingRegistration() {
        let reg = self.registrationMap.registrationForType(Trout.self)
        XCTAssert(reg!.cache, "Registration Map: Type Map is overriding existing registration")
    }
}
