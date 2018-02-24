//
//  Global.swift
//  Munchkin
//
//  Created by Peter Terpstra on 2/23/18.
//  Copyright © 2018 Peter Terpstra. All rights reserved.
//

import Foundation

let cards = [
    Card(description: "Freezing Explosive Potion", strength: 3),
    Card(description: "Nasty Tasting Sports Drink", strength: 2),
    Card(description: "Electric Radioactive Acid Potion", strength: 5),
    Card(description: "Potion of Idiotic Bravery", strength: 2),
    Card(description: "Magic Missile", strength: 5),
    Card(description: "Flaming Poison Potion", strength: 3),
    Card(description: "Sleep Potion", strength: 2),
    Card(description: "Pretty Ballons", strength: 5),
    Card(description: "Cotion of Ponfusion", strength: 3),
    Card(description: "Potion of Halitosis", strength: 2),
    Card(description: "Chainsaw of Bloody Dismemberment", strength: 3, big:false, kind: WeaponKind.TwoHands),
    Card(description: "Flaming Armor", strength: 2, big:false, kind:WeaponKind.Armor),
    Card(description: "Buckler of Swashing", strength: 2, big:false, kind:WeaponKind.OneHand),
    Card(description: "Slimy Armor", strength: 1, big:false, kind:WeaponKind.Armor),
    Card(description: "Spiky Knees", strength: 1, big:false, kind:WeaponKind.None),
    Card(description: "Helm of Courage", strength: 1, big:false, kind:WeaponKind.Headgear),
    Card(description: "Boots of Butt-Kicking", strength: 2, big:false, kind:WeaponKind.Footgear),
    Card(description: "Eleven-Foot Pole", strength: 1, big:false, kind:WeaponKind.TwoHands),
    Card(description: "Sneaky Bastard Sword", strength: 2, big:false, kind:WeaponKind.OneHand),
    Card(description: "Really Impressive Title", strength: 3, big:false, kind:WeaponKind.None),
    Card(description: "Huge Rock", strength: 3, big:true, kind:WeaponKind.None),
    Card(description: "Leather Armor", strength: 1, big:false, kind:WeaponKind.Armor),
    Card(description: "Rat on a Stick", strength: 1, big:false, kind:WeaponKind.None),
    Card(description: "Baby", strength: -5, affects: Side.Monster),
    Card(description: "Shrieking Geek", strength: 6, treasures: 2, abilities: [Ability(type: "Strength", properties:["Warrior":5])])
    
]

var handCards:[Card] = []
var playCards:[Card] = []
var currentCard:Card? = nil
