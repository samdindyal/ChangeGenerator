//
//  Coin.swift
//  ChangeGenerator
//
//  Created by Sam Dindyal on 2018-08-07.
//  Copyright © 2018 Sam Dindyal. All rights reserved.
//

import UIKit

class Coin {
    var name:String
    var value:Float
    var quantity:Int
    var active:Bool
    
    init(name: String, value: Float, quantity: Int = 0, active: Bool = true) {
        self.name       = name
        self.value      = value
        self.quantity   = quantity
        self.active     = active
    }
}
