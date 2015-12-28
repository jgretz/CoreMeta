//
//  CMContainerGeneratorLamdaTests.swift
//  CoreMeta
//
//  Created by Scott Ferguson on 12/23/15.
//  Copyright © 2015 Truefit. All rights reserved.
//

import Foundation
import XCTest

class RegisteredClass: NSObject, RegisteredProtocol {
}

@objc
protocol RegisteredProtocol {
    
}

class InjectedClass : NSObject {
    var generator : (() -> RegisteredClass)!
}

class InjectedProtocolClass : NSObject {
    var generator : (() -> RegisteredProtocol)!
}

class CMGeneratorTests : XCTestCase {
    
    private var container : CMContainer!
    
    override func setUp() {
        super.setUp()
        
        container = CMContainer()
        container.registerClass(RegisteredClass.self, cache: true)
        container.registerClassAsProtocol(RegisteredClass.self, p: RegisteredProtocol.self)
    }
    
    func testItShouldInjectACMGeneratorInstance() {
        
        let injected = container.objectForType(InjectedClass) as! InjectedClass
        
        XCTAssertNotNil(injected.generator, "The generator implemention was not set")
    }
    
    func testTheGeneratorShouldReturnAnInstanceFromTheContianer() {
        
        container.registerClass(RegisteredClass.self, cache: true)
        
        let registered = container.objectForType(RegisteredClass)
        
        let injected = container.objectForType(InjectedClass) as! InjectedClass
        
        let generated = injected.generator()
        
        XCTAssertEqual(registered, generated, "The generator did not return the instance from the container")
    }
    
    func testTheGeneratorShouldReturnAnInstanceForAProtocol() {
        
        container.registerClass(RegisteredClass.self, cache: true)
        container.registerClassAsProtocol(RegisteredClass.self, p: RegisteredProtocol.self)
        
        let registered = container.objectForType(RegisteredClass)
        
        let injected = container.objectForType(InjectedProtocolClass) as! InjectedProtocolClass
        
        let generated = injected.generator()
        
        XCTAssertTrue(registered === generated, "The generator did not return the instance from the container")
    }
}