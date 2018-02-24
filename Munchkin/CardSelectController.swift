//
//  CardSelectController.swift
//  Munchkin
//
//  Created by Peter Terpstra on 2/23/18.
//  Copyright © 2018 Peter Terpstra. All rights reserved.
//

import Cocoa

class CardSelectController: NSViewController {
    
    @IBOutlet weak var cardMenu: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for card in cards {
            cardMenu.addItem(withTitle: card.description)
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    @IBAction func addButtonClicked(_ sender: Any) {
        handCards.append(cards[cardMenu.indexOfSelectedItem])
        NotificationCenter.default.post(name: Notification.Name(rawValue: "update"), object: self)
    }
    
}
