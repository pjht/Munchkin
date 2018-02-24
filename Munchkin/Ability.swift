//
//  Ability.swift
//  Munchkin
//
//  Created by Peter Terpstra on 2/24/18.
//  Copyright © 2018 Peter Terpstra. All rights reserved.
//

import Foundation

class Ability {
    var type: String
    var properties: [String:Any]?
    init(type: String) {
        self.type = type
        properties = nil
    }
    init(type: String, properties: [String:Any]) {
        self.type = type
        self.properties = properties
    }
}
