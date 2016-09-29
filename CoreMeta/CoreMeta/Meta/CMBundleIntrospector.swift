//
// Created by Joshua Gretz on 10/28/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

open class CMBundleIntrospector {
    public init() {
    }
    
    open func classesThatConformToProtocol(_ p: Protocol) -> Array<NSObject.Type> {
        let classes = getClassList()
        var result = Array<NSObject.Type>()
        
        for c in classes {
            if class_conformsToProtocol(c, p) {
                result.append(c as! NSObject.Type)
            }
        }
        return result
    }
    
    func getClassList() -> [AnyClass] {
        let expectedClassCount = objc_getClassList(nil, 0)
        let capacity = Int(expectedClassCount)
        
        let allClasses = UnsafeMutablePointer<AnyClass?>.allocate(capacity: capacity)
        let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass?>(allClasses)
        let actualClassCount:Int32 = objc_getClassList(autoreleasingAllClasses, expectedClassCount)
        
        var classes = [AnyClass]()
        for i in 0 ..< actualClassCount {
            if let currentClass: AnyClass = allClasses[Int(i)] {
                classes.append(currentClass)
            }
        }
        
        allClasses.deallocate(capacity: capacity)
        
        return classes
    }
}
