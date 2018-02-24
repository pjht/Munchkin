//
//  AffectsSelectController.swift
//  Munchkin
//
//  Created by Peter Terpstra on 2/24/18.
//  Copyright © 2018 Peter Terpstra. All rights reserved.
//

import Cocoa

class AffectsSelectController: NSViewController {
    
    @IBOutlet weak var affectsMenu: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func setButtonClicked(_ sender: Any) {
        if affectsMenu.titleOfSelectedItem != nil && currentCard != nil {
            let selection = affectsMenu.titleOfSelectedItem!
            let card = currentCard!
            switch (selection) {
            case "Player":
                card.affects=Side.Player
            case "Monster":
                card.affects=Side.Monster
            default: break
            }
            playCards.append(card)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "update"), object: self)
            currentCard=nil
            self.dismiss(self)
        }
    }
}
