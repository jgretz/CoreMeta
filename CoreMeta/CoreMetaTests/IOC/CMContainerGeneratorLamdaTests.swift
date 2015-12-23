//
//  CMContainerGeneratorLamdaTests.swift
//  CoreMeta
//
//  Created by Scott Ferguson on 12/23/15.
//  Copyright © 2015 Truefit. All rights reserved.
//

import Foundation
import XCTest


class CMGeneratorTests : XCTestCase {
    
    private var container : CMContainer!
    
    class RegisteredClass :NSObject {
    }


    class InjectedClass : NSObject {
        var generator = CMGenerator<RegisteredClass>()
    }
    
    override func setUp() {
        super.setUp()
        
        container = CMContainer()
        
    }
    
    func testItShouldInjectACMGeneratorInstance() {
        
        let injected = container.objectForType(InjectedClass) as! InjectedClass
        
        XCTAssertNotNil(injected.generator.generateImpl, "The generator implemention was not set")
    }
    
    func testTheGeneratorShouldReturnAnInstanceFromTheContianer() {
        container.registerClass(RegisteredClass.self, cache: true)
        let registered = container.objectForType(RegisteredClass)
        
        let injected = container.objectForType(InjectedClass) as! InjectedClass
        
        let generated = injected.generator.generate()
        
        XCTAssertEqual(registered, generated, "The generator did not return the instance from the container")
    }
}