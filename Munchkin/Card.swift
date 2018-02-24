//
//  Card.swift
//  Munchkin
//
//  Created by Peter Terpstra on 2/23/18.
//  Copyright © 2018 Peter Terpstra. All rights reserved.
//

import Foundation

class Card {
    let type: CardType
    let description: String
    var affects: Side?
    let strength: Int?
    let treasures: Int?
    let abilities:[Ability]?
    let big:Bool?
    let kind:WeaponKind?
    var affectsString: String {
        get {
            if affects != nil {
                switch (affects!) {
                case Side.Player:
                    return "Player"
                case Side.Monster:
                    return "Monster"
                }
            } else {
                return ""
            }
        }
    }
    
    var strengthString: String {
        get {
            if strength != nil {
                let strength=self.strength!
                if strength > 0 {
                    return "+\(strength)"
                } else {
                    return "\(strength)"
                }
            } else {
                return ""
            }
        }
    }
    
    init(description: String, abilities:[Ability],race:Bool) {
        if race {
           self.type=CardType.Race
        } else {
            self.type=CardType.Class
        }
        self.description=description
        affects=nil
        strength=nil
        treasures=nil
        self.abilities=abilities
        self.big=nil
        self.kind=nil
    }
    
    
    init(description: String, abilities:[Ability]) {
        self.type=CardType.Class
        self.description=description
        affects=nil
        strength=nil
        treasures=nil
        self.abilities=abilities
        self.big=nil
        self.kind=nil
    }
    
    init(description: String, strength: Int) {
        self.type=CardType.OneUse
        self.description=description
        self.strength=strength
        treasures=nil
        abilities=nil
        self.big=nil
        self.kind=nil
    }
    
    init(description: String, strength: Int, big:Bool, kind:WeaponKind) {
        self.type=CardType.OneUse
        self.description=description
        self.strength=strength
        treasures=nil
        abilities=nil
        self.affects=Side.Player
        self.big=big
        self.kind=kind
    }
    
    init(description: String, strength: Int, affects: Side) {
        self.type=CardType.OneUse
        self.description=description
        self.strength=strength
        self.affects=affects
        treasures=nil
        abilities=nil
        self.big=nil
        self.kind=nil
    }
    
    init(description: String, strength: Int, treasures: Int, abilities:[Ability]) {
        type=CardType.Monster
        self.description=description
        self.strength=strength
        affects=nil
        self.treasures=treasures
        self.abilities=abilities
        self.big=nil
        self.kind=nil
    }
    
    init(description: String, strength: Int, treasures: Int) {
        self.type=CardType.Monster
        self.description=description
        self.strength=strength
        affects=nil
        self.treasures=treasures
        self.abilities=nil
        self.big=nil
        self.kind=nil
    }
    

}
