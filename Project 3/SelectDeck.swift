//
//  SelectDeck.swift
//  Project 3
//
//  Created by James Glass on 11/16/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

/// Class that handles Player 1's class cards selection.
/// Player 1 can either be a Mage, Warrior, or Goblin.
class SelectionDeck1: UIViewController {
    /// Variable for player 1's current deck. Contiains a dummy string value.
    var currDeck = ["Initial"];
    override func viewDidLoad() {
        //Nothing yet :)
    }
    @IBOutlet weak var segmentSelect: UISegmentedControl!
    
    let warriorDeck = ["Sword-Strike-Deck", "Sword-Strike-Deck", "Double-Edge-Deck", "Disarm-Deck", "Disarm-Deck", "Blacksmith-Deck", "Liquid-Courage-Deck", "Liquid-Courage-Deck", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"]
    
    let mageDeck = ["Magical-Bolt-Deck", "Magical-Bolt-Deck", "Arcane-Burst-Deck", "Voodoo-Doll-Deck", "Voodoo-Doll-Deck", "Spell-Tome-Deck", "Mana-Potion-Deck", "Mana-Potion-Deck", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"]
    
    let goblinDeck = ["Horde-Ransack-Deck", "Horde-Ransack-Deck", "Loot-Tool-Deck", "Goblin-Greed-Deck", "Sleight-of-Hand-Deck", "Handy-Discount-Deck", "Money-is-Power-Deck", "Coin-Craze-Deck", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"]
    
    ///Function that is called once Player 1 presses the Select Class button to confirm their class.
    ///This sets which deck Player 1 will use.
    /// - Sources:
    ///     - function adapted from https://stackoverflow.com/questions/31587181/sending-array-data-from-one-view-controller-to-another
    /// - Parameters:
    ///   - sender: function called when button is pressed
    @IBAction func confirmSelection(_ sender: Any) {
        switch segmentSelect.selectedSegmentIndex
        {
        case 0:
            let defaults = UserDefaults.standard
            //currDeck = warriorDeck.shuffled()
            currDeck = warriorDeck
            defaults.set(currDeck, forKey: "deck1")
            
        case 1:
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = mageDeck
            defaults.set(currDeck, forKey: "deck1")
        case 2:
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = goblinDeck
            defaults.set(currDeck, forKey: "deck1")
        default:
            currDeck = ["ERROR"]
            break
        }
    }
    
    /// Function that shows Warrior cards as a popup for Player 1 when Warrior's picture is clicked.
    @IBAction func warriorPress(_ sender: Any) {
        let popup = UIStoryboard(name: "GamePlayingScreen", bundle: nil).instantiateViewController(withIdentifier: "warriorPopupID") as! warriorPopup
        self.addChildViewController(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParentViewController: self)
    }
    
    /// Function that shows Mage cards as a popup for Player 1 when Mage's picture is clicked.
    @IBAction func magePress(_ sender: Any) {
        let popup = UIStoryboard(name: "GamePlayingScreen", bundle: nil).instantiateViewController(withIdentifier: "magePopupID") as! magePopup
        self.addChildViewController(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParentViewController: self)
    }
    
    /// Function that shows Goblin cards as a popup for Player 1 when Goblin's picture is clicked.
    @IBAction func goblinPress(_ sender: Any) {
        let popup = UIStoryboard(name: "GamePlayingScreen", bundle: nil).instantiateViewController(withIdentifier: "goblinPopupID") as! goblinPopup
        self.addChildViewController(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParentViewController: self)
    }
}

/// Class that handles Player 1's class cards selection.
/// Player 1 can either be a Mage, Warrior, or Goblin.
class SelectionDeck2: UIViewController {
    /// Variable for player 1's current deck. Contiains a dummy string value.
    var currDeck = ["Initial"];
    override func viewDidLoad() {
        //Nothing yet :)
    }
    @IBOutlet weak var segmentSelect: UISegmentedControl!
    
    let warriorDeck = ["Sword-Strike-Deck", "Sword-Strike-Deck", "Double-Edge-Deck", "Disarm-Deck", "Disarm-Deck", "Blacksmith-Deck", "Liquid-Courage-Deck", "Liquid-Courage-Deck", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"]
    
    let mageDeck = ["Magical-Bolt-Deck", "Magical-Bolt-Deck", "Arcane-Burst-Deck", "Voodoo-Doll-Deck", "Voodoo-Doll-Deck", "Spell-Tome-Deck", "Mana-Potion-Deck", "Mana-Potion-Deck", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"]
    
    let goblinDeck = ["Horde-Ransack-Deck", "Horde-Ransack-Deck", "Loot-Tool-Deck", "Goblin-Greed-Deck", "Sleight-of-Hand-Deck", "Handy-Discount-Deck", "Money-is-Power-Deck", "Coin-Craze-Deck", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"]
    
    ///Function that is called once Player 2 presses the Select Class button to confirm their class.
    ///This sets which deck Player 2 will use.
    /// - Sources:
    ///     - function adapted from https://stackoverflow.com/questions/31587181/sending-array-data-from-one-view-controller-to-another
    /// - Parameters:
    ///   - sender: function called when button is pressed
    @IBAction func confirmSelection(_ sender: Any) {
        switch segmentSelect.selectedSegmentIndex
        {
        case 0:
            let defaults = UserDefaults.standard
            //currDeck = warriorDeck.shuffled()
            currDeck = warriorDeck
            defaults.set(currDeck, forKey: "deck2")
        case 1:
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = mageDeck
            defaults.set(currDeck, forKey: "deck2")
        case 2:
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = goblinDeck
            defaults.set(currDeck, forKey: "deck2")
        default:
            currDeck = ["ERROR"]
            break
        }
    }
    
    /// Function that shows Warrior cards as a popup for Player 2 when Warrior's picture is clicked.
    ///
    /// - Parameter sender: Player pressing button
    @IBAction func warriorPress(_ sender: Any) {
        let popup = UIStoryboard(name: "GamePlayingScreen", bundle: nil).instantiateViewController(withIdentifier: "warriorPopupID") as! warriorPopup
        self.addChildViewController(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParentViewController: self)
    }
    
    /// Function that shows Mage cards as a popup for Player 1 when Mage's picture is clicked.
    ///
    /// - Parameter sender: Player pressing button
    @IBAction func magePress(_ sender: Any) {
        let popup = UIStoryboard(name: "GamePlayingScreen", bundle: nil).instantiateViewController(withIdentifier: "magePopupID") as! magePopup
        self.addChildViewController(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParentViewController: self)
    }
    
    /// Function that shows Goblin cards as a popup for Player 1 when Goblin's picture is clicked.
    ///
    /// - Parameter sender: Player pressing button
    @IBAction func goblinPress(_ sender: Any) {
        let popup = UIStoryboard(name: "GamePlayingScreen", bundle: nil).instantiateViewController(withIdentifier: "goblinPopupID") as! goblinPopup
        self.addChildViewController(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParentViewController: self)
    }
}

