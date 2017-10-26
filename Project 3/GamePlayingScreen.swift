//
//  PlsWork.swift
//  Project 3
//
//  Created by Giovanni on 10/24/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

class ViewPlayGame: UIViewController {
    @IBOutlet weak var metal: UIImageView!
    class Mage
    {
        let mageDeck = ["electric", "fire"]
        var currDeck: [String]?
        var currStamina = 2
        var totalStamina: Int?
        var health = 20
        var attack = 0
        var buffArr: [String]?
        var debuff: String?
        var shuffleCount = 2
        
        func getMageDeck() -> [String]{
            return mageDeck
        }
    }
    
    class Warrior
    {
        let warriorDeck = ["electric", "fire"]
        var currDeck: [String]?
        var currStamina = 2
        var totalStamina: Int?
        var health = 20
        var attack = 0
        var buffArr: [String]?
        var debuff: String?
        var shuffleCount = 2
    }
    
    let player1 = Mage()
    let player2 = Warrior()

    
    func deckShuffle(deck: [String]) -> [String]
    {
        //shuffle deck
        return deck
    }
    
    //var test = deckShuffle(deck: player1.getMageDeck())

    @IBOutlet weak var playCardButton: UIButton!
    @IBOutlet weak var placeBottomButton: UIButton!
    @IBOutlet weak var endTurnButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var surrenderButton: UIButton!
    
    
    @IBAction func playCardPress(_ sender: Any) {
    }
    @IBAction func placeBottomPress(_ sender: Any) {
    }
    @IBAction func endTurnPress(_ sender: Any) {
    }
    @IBAction func shufflePress(_ sender: Any) {
    }
    @IBAction func surrenderPress(_ sender: Any) {
    }
}

