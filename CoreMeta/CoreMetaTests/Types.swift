//
// Created by Joshua Gretz on 10/23/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

@objc protocol Lizard {}
@objc protocol Fish {}
class Trout : NSObject, Fish {}

class Tree : NSObject {}
class Leaf : NSObject {}

class Flower : NSObject {}
class Rose : NSObject {}


class FruitTree: NSObject {
    var fruit: Array<Fruit>
    var color: String

    init(fruit: Array<Fruit>, color: String) {
        self.fruit = fruit
        self.color = color
    }

}

class Fruit: NSObject {
    var name: String

    init(name: String) {
        self.name = name
    }
}


