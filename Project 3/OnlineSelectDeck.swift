//
//  SelectDeck.swift
//  Project 3
//
//  Created by James Glass on 11/16/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

/// Online class that handles Player 1's class cards selection.
/// Player 1 can either be a Mage, Warrior, or Goblin.
class OnlineSelectionDeck1: UIViewController {
    let screenService = ScreenServiceManager()

    var currDeck = ["Initial"];
    override func viewDidLoad() {
        super.viewDidLoad()
        screenService.delegate = self
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
            screenService.send(screenName: "p1.0")
            let defaults = UserDefaults.standard
            //currDeck = warriorDeck.shuffled()
            currDeck = warriorDeck
            defaults.set(currDeck, forKey: "deck1")
            
        case 1:
            screenService.send(screenName: "p1.1")
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()jk
            currDeck = mageDeck
            defaults.set(currDeck, forKey: "deck1")
        case 2:
            screenService.send(screenName: "p1.2")
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = goblinDeck
            defaults.set(currDeck, forKey: "deck1")
        default:
            currDeck = ["ERROR"]
            break
        }
        
        //move to next view controller
        let storyboard = UIStoryboard(name: "OnlineGamePlayingScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier : ("Player2Selection"))
        self.present(viewController, animated: true)
    }
    
    /// Chooses which deck the other player chooses
    func confirmSelectionOnline1(selectedSegment: String)
    {
        switch selectedSegment
        {
        case "0":
            let defaults = UserDefaults.standard
            //currDeck = warriorDeck.shuffled()
            currDeck = warriorDeck
            defaults.set(currDeck, forKey: "deck1")
            
        case "1":
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = mageDeck
            defaults.set(currDeck, forKey: "deck1")
        case "2":
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = goblinDeck
            defaults.set(currDeck, forKey: "deck1")
        default:
            currDeck = ["ERROR"]
            break
        }

        
        //move to next view controller

    }
}

/// Online class that handles Player 2's class cards selection.
/// Player 2 can either be a Mage, Warrior, or Goblin.
class OnlineSelectionDeck2: UIViewController
{
    let screenService = ScreenServiceManager()
    var currDeck = ["Initial"];
    override func viewDidLoad() {
        super.viewDidLoad()
        screenService.delegate = self
    }
    @IBOutlet weak var segmentSelect: UISegmentedControl!
    
    /*let warriorDeck = ["Throwing-Knife-Deck", "Throwing-Knife-Deck","Liquid-Courage-Deck","Liquid-Courage-Deck","Liquid-Courage-Deck","Brass-Knuckles-Deck", "Brass-Knuckles-Deck", "Disarm-Deck", "Disarm-Deck", "Blacksmith-Deck", "Smoke-Bomb-Deck", "Smoke-Bomb-Deck", "Double-Edge-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Bad-Medicine-Deck", "Bad-Medicine-Deck", "Sword-Strike-Deck", "Sword-Strike-Deck", "Sword-Strike-Deck"]
    
    let mageDeck = ["Life-Steal-Deck", "Life-Steal-Deck","Mana-Potion-Deck","Mana-Potion-Deck","Mana-Potion-Deck","Voodoo-Doll-Deck", "Voodoo-Doll-Deck", "Disarm-Deck", "Disarm-Deck", "Spell-Tome-Deck", "Smoke-Bomb-Deck", "Smoke-Bomb-Deck", "Arcane-Burst-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Bad-Medicine-Deck", "Bad-Medicine-Deck", "Magical-Bolt-Deck", "Magical-Bolt-Deck", "Magical-Bolt-Deck"]*/
    
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
            screenService.send(screenName: "p2.0")
            let defaults = UserDefaults.standard
            //currDeck = warriorDeck.shuffled()
            currDeck = warriorDeck
            defaults.set(currDeck, forKey: "deck2")
        case 1:
            screenService.send(screenName: "p2.1")
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = mageDeck
            defaults.set(currDeck, forKey: "deck2")
        case 2:
            screenService.send(screenName: "p2.2")
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = goblinDeck
            defaults.set(currDeck, forKey: "deck2")
        default:
            currDeck = ["ERROR"]
            break
        }
        //move to next view controller
        let storyboard = UIStoryboard(name: "OnlineGamePlayingScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier : ("CoinFlip"))
        self.present(viewController, animated: true)
    }
    func confirmSelectionOnline2(selectedSegment: String)
    {
        switch selectedSegment
        {
        case "0":
            let defaults = UserDefaults.standard
            //currDeck = warriorDeck.shuffled()
            currDeck = warriorDeck
            defaults.set(currDeck, forKey: "deck2")
            
        case "1":
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = mageDeck
            defaults.set(currDeck, forKey: "deck2")
        case "2":
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = goblinDeck
            defaults.set(currDeck, forKey: "deck2")
        default:
            currDeck = ["ERROR"]
            break
        }
        
    }
}



extension OnlineSelectionDeck1 : ScreenServiceManagerDelegate
{
    
    
    func connectedDevicesChanged(manager: ScreenServiceManager, connectedDevices: [String])
    {
        OperationQueue.main.addOperation
            {
                //self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    
    func screenChanged(manager: ScreenServiceManager, screenString: String)
    {
        OperationQueue.main.addOperation
            {
                //determine which btton was pressed and push changes to all screens
                switch screenString
                {
                case "p1.0":
                    self.confirmSelectionOnline1(selectedSegment: "0")
                    //move to next view controller
                    let storyboard = UIStoryboard(name: "OnlineGamePlayingScreen", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier : ("Player2Selection"))
                    self.present(viewController, animated: true)
                case "p1.1":
                    self.confirmSelectionOnline1(selectedSegment: "1")
                    //move to next view controller 
                    let storyboard = UIStoryboard(name: "OnlineGamePlayingScreen", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier : ("Player2Selection"))
                    self.present(viewController, animated: true)
                case "p1.2":
                    self.confirmSelectionOnline1(selectedSegment: "2")
                    //move to next view controller
                    let storyboard = UIStoryboard(name: "OnlineGamePlayingScreen", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier : ("Player2Selection"))
                    self.present(viewController, animated: true)
                default:
                    NSLog("%@", "Unknown value received: \(screenString)")
                }
                
        }
    }
    
}

extension OnlineSelectionDeck2 : ScreenServiceManagerDelegate
{
    
    
    func connectedDevicesChanged(manager: ScreenServiceManager, connectedDevices: [String])
    {
        OperationQueue.main.addOperation
            {
                //self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    
    func screenChanged(manager: ScreenServiceManager, screenString: String)
    {
        OperationQueue.main.addOperation
            {
                //determine which button was pressed and push changes to all screens
                switch screenString
                {
                case "p2.0":
                    self.confirmSelectionOnline2(selectedSegment: "0")
                    //move to next view controller
                    let storyboard = UIStoryboard(name: "OnlineGamePlayingScreen", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier : ("CoinFlip"))
                    self.present(viewController, animated: true)
                case "p2.1":
                    self.confirmSelectionOnline2(selectedSegment: "1")
                    //move to next view controller
                    let storyboard = UIStoryboard(name: "OnlineGamePlayingScreen", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier : ("CoinFlip"))
                    self.present(viewController, animated: true)
                case "p2.2":
                    self.confirmSelectionOnline2(selectedSegment: "2")
                    //move to next view controller
                    let storyboard = UIStoryboard(name: "OnlineGamePlayingScreen", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier : ("CoinFlip"))
                    self.present(viewController, animated: true)
                default:
                    NSLog("%@", "Unknown value received: \(screenString)")
                }

                
        }
    }
    
}

