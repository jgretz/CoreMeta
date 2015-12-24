//
//  CMGenerator.swift
//  CoreMeta
//
//  Created by Scott Ferguson on 12/23/15.
//  Copyright © 2015 Truefit. All rights reserved.
//

import Foundation

protocol CMGeneratorProtocol {
    var type : Any.Type { get }
    var generateImpl: (() -> AnyObject)! { get set }
}

public class CMGenerator<T> : CMGeneratorProtocol {
    
    public init() {
    }
    
    public func generate() -> T {
        return generateImpl() as! T
    }
    
    var type : Any.Type {
        get { return T.self }
    }
    
    var generateImpl : (() -> AnyObject)!
}
