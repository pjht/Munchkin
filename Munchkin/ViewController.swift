//
//  ViewController.swift
//  Munchkin
//
//  Created by Peter Terpstra on 2/22/18.
//  Copyright © 2018 Peter Terpstra. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var playerLevelLabel: NSTextField!
    @IBOutlet weak var playerScoreLabel: NSTextField!
    @IBOutlet weak var monsterScoreLabel: NSTextField!
    @IBOutlet weak var handCardsTable: NSTableView!
    @IBOutlet weak var playCardsTable: NSTableView!
    @IBOutlet weak var currentMonsterLabel: NSTextField!
    @IBOutlet weak var statusLabel: NSTextField!
    
    var playerLevel = 1
    var playerScore = 1
    var monsterScore = 0
    var currentMonster = ""
    var status = ""
    var monsterCard:Card? = nil
    
    var gameInProgress = true
    let forcePlayer = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handCardsTable.delegate = self
        handCardsTable.dataSource = self
        playCardsTable.delegate = self
        playCardsTable.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotification(notification:)), name: NSNotification.Name(rawValue: "update"), object: nil)
        newGameClicked(self)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func reloadCards() {
        handCardsTable.reloadData()
        playCardsTable.reloadData()
    }
    
    
    func updateLabels() {
        playerLevelLabel.integerValue = playerLevel
        playerScoreLabel.integerValue = playerScore
        monsterScoreLabel.integerValue = monsterScore
        currentMonsterLabel.stringValue = currentMonster
        statusLabel.stringValue = status
    }
    
    func calculateStats() {
        playerScore=playerLevel
        monsterScore=0
        monsterCard=nil
        var monsterModifiers:[Card] = []
        var playerModifiers:[Card] = []
        for card in playCards {
            switch(card.type) {
            case .Monster:
                monsterCard = card
            case .OneUse:
                switch (card.affects!) {
                case .Player:
                    playerModifiers.append(card)
                case .Monster:
                    monsterModifiers.append(card)
                }
            case .Weapon:
                playerModifiers.append(card)
            default: break
            }
        }
        
        for card in playerModifiers {
            playerScore += card.strength!
        }
        
        if monsterCard != nil {
            monsterScore=monsterCard!.strength!
            for card in monsterModifiers {
                monsterScore += card.strength!
            }
            currentMonster = monsterCard!.description
        } else {
            currentMonster = ""
        }
        if playerLevel == 10 {
            status="You win the game!"
            gameInProgress=false
        }
        updateLabels()
    }
    
    func update() {
        reloadCards()
        calculateStats()
        updateLabels()
    }
    
    @objc func updateNotification(notification: NSNotification) {
        update()
    }
    
    func openAffectsSelect() {
        let myStoryboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"),bundle: nil)
        if let vc = myStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "AffectsSelect")) as? AffectsSelectController {
            let myWindow = NSWindow(contentViewController: vc)
            myWindow.makeKeyAndOrderFront(self)
            let controller = NSWindowController(window: myWindow)
            controller.showWindow(self)
        } else {
            print("Could not open AffectsSelect")
        }
    }
    
    func openCardSelect() {
        let myStoryboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"),bundle: nil)
        if let vc = myStoryboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "CardSelect")) as? CardSelectController {
            let myWindow = NSWindow(contentViewController: vc)
            myWindow.makeKeyAndOrderFront(self)
            let controller = NSWindowController(window: myWindow)
            controller.showWindow(self)
        } else {
            print("Could not open CardSelect")
        }
    }
    
    @IBAction func newGameClicked(_ sender: Any) {
        playerLevel = 1
        playerScore = 1
        monsterScore = 0
        handCards = []
        playCards = []
        status=""
        gameInProgress=true
        update()
    }
    
    @IBAction func handAddClicked(_ sender: Any) {
        if gameInProgress {
                    openCardSelect()
        }
    }
    
    @IBAction func handRemoveClicked(_ sender: Any) {
        if gameInProgress {
            let index = handCardsTable.selectedRow
            if index != -1 {
                handCards.remove(at:index)
                reloadCards()
            }
        }
    }
    
    @IBAction func handMoveClicked(_ sender: Any) {
        if gameInProgress {
            let index = handCardsTable.selectedRow
            if index != -1 {
                let card = handCards[index]
                if card.affects == nil && card.type != .Monster {
                    currentCard=card
                    handCards.remove(at: index)
                    if forcePlayer {
                        if card.affects == nil {
                            card.affects=Side.Player
                            playCards.append(card)
                        }
                        reloadCards()
                    } else {
                        openAffectsSelect()
                    }
                } else {
                    playCards.append(card)
                    handCards.remove(at: index)
                    reloadCards()
                    calculateStats()
                }
            }
        }
    }

    @IBAction func playMoveClicked(_ sender: Any) {
        if gameInProgress {
            let index = playCardsTable.selectedRow
            if index != -1 {
                let card = playCards[index]
                playCards.remove(at: index)
                handCards.append(card)
                reloadCards()
            }
            calculateStats()
        }
    }
    
    @IBAction func fightButtonClicked(_ sender: Any) {
        if gameInProgress {
            if monsterCard != nil {
                if playerScore > monsterScore {
                    status="You win the battle! Draw \(monsterCard!.treasures!) treasures"
                    playerLevel+=1
                } else {
                    status="You lose"
                }
                var newPlayCards:[Card]=[]
                for card in playCards {
                    if card.type != .OneUse && card.type != .Monster {
                        newPlayCards.append(card)
                    }
                }
                playCards=newPlayCards
                monsterCard=nil
            } else {
                if status == "Uhh, there's no monster to fight" {
                    status = "I told you, there's no monster"
                } else if status == "I told you, there's no monster" {
                    status = "SERIOUSLY! THERE'S NO MONSTER!"
                } else if status != "SERIOUSLY! THERE'S NO MONSTER!" {
                    status = "Uhh, there's no monster to fight"
                }
            }
            update()
        }
    }
}

extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView == handCardsTable {
            return handCards.count
        } else if tableView == playCardsTable {
            return playCards.count
        }
        return 0
    }
    
}

extension ViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let NameCellHand = "NameCellHandID"
        static let NameCellPlay = "NameCellPlayID"
        static let AffectsCell = "AffectsCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

        var text: String = ""
        var cellIdentifier: String = ""
    
        switch tableView {
        case handCardsTable:
            text=handCards[row].description
            cellIdentifier = CellIdentifiers.NameCellHand
        case playCardsTable:
            switch tableColumn {
            case tableView.tableColumns[0]?:
                text=playCards[row].description
                cellIdentifier = CellIdentifiers.NameCellPlay
            case tableView.tableColumns[1]?:
                if playCards[row].strength != nil && playCards[row].affects != nil {
                    let strength=playCards[row].strengthString
                    let affects=playCards[row].affectsString
                    text="\(affects) (\(strength))"
                } else {
                    text=""
                }
                cellIdentifier = CellIdentifiers.AffectsCell
            case .none:
                text=""
            case .some(_):
                text=""
            }
        default:
            text=""
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
    
}
