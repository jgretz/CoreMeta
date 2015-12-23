//
//  CMGenerator.swift
//  CoreMeta
//
//  Created by Scott Ferguson on 12/23/15.
//  Copyright © 2015 Truefit. All rights reserved.
//

import Foundation

internal protocol CMGeneratorProtocol {
    func generatorType() -> AnyClass
    var generateImpl: (() -> AnyObject)! { get set }
}

public class CMGenerator<T:NSObject> : CMGeneratorProtocol {
    
    public init() {}
    
    public func generate() -> T {
        return generateImpl() as! T
    }
    
    internal func generatorType() -> AnyClass {
        return T.self
    }
    
    internal var generateImpl : (() -> AnyObject)!
}
