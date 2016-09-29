//
// Created by Joshua Gretz on 10/23/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

class Tree : NSObject {}
class Leaf : NSObject {}

class Flower : NSObject {}
class Rose : NSObject {}

//******************

@objc protocol Lizard {}
@objc protocol Fish {}

class Trout : NSObject, Fish {}
class Shark : NSObject {
    var name:String?
}
class Whale : NSObject {}
class Turtle : NSObject {}

class Ocean : NSObject {
    var fish: Fish?
    var shark : Shark?
    var whale : Whale?

    var depth = 12.5

    fileprivate(set) var turtle : Turtle?
}

class Pond: Ocean {
}

//******************

class Pizza : NSObject, CMContainerAutoRegister {
    var name:String?

    class func cache() -> Bool {
        return true
    }

    class func onCreate() -> (NSObject) -> Void {
        return { ($0 as! Pizza).name = "Pep" }
    }
}

class Cake : NSObject {
    var flavor:String?
    var color:String?
    var filling:String?
    var icing = false

    override init() {
        super.init()
    }

    convenience init(flavor:String?, color:String?, icing: Bool, filling:String?) {
        self.init()

        self.flavor = flavor
        self.color = color
        self.icing = icing
        self.filling = filling
    }
}
