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
    
    init(name: String, value: Float, quantity: Int = 0) {
        self.name       = name
        self.value      = value
        self.quantity   = quantity
    }
}
