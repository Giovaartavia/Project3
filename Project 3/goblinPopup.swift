//
//  goblinPopup.swift
//  Project 3
//
//  Created by Dylan Herrig on 11/23/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

/// goblinPopup class that pops up an overlay that displays the goblin cards
/// - Sources:
///     - function for creating popup adapted from https://www.youtube.com/watch?v=FgCIRMz_3dE
///
class goblinPopup: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    /// Closes the popup when pressed.
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    ///displays the number of the shown card in the deck
    @IBOutlet weak var numInDeck: UILabel!
    ///displays the card image
    @IBOutlet weak var cardImage: UIImageView!
    
    let deckArray = ["Horde-Ransack-Single", "Loot-Tool-Single", "Goblin-Greed-Single", "Sleight-of-Hand-Single", "Handy-Discount-Single", "Money-is-Power-Single", "Coin-Craze-Single"];
    var loc = 0;
    
    ///shows the next card and updates the number of cards in the deck
    @IBAction func nextCard(_ sender: Any) {
        //print("NEXT")
        if(loc == 6)
        {
            loc = 0;
        }
        else
        {
            loc = loc+1;
        }
        if(loc == 0)
        {
            numInDeck.text="2 IN DECK";
        }
        else
        {
            numInDeck.text="1 IN DECK";
        }
        cardImage.image = UIImage(named: deckArray[loc]);
    }
    
    ///shows the prev card and updates the number of cards in the deck
    @IBAction func prevCard(_ sender: Any) {
        //print("PREV")
        if(loc == 0)
        {
            loc = 6;
        }
        else
        {
            loc = loc-1;
        }
        if(loc == 0)
        {
            numInDeck.text="2 IN DECK";
        }
        else
        {
            numInDeck.text="1 IN DECK";
        }
        cardImage.image = UIImage(named: deckArray[loc]);
    }
}


