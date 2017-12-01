//
//  magePopup.swift
//  Project 3
//
//  Created by Dylan Herrig on 11/23/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

/// magePopup class that pops up an overlay that displays the mage cards
/// - Sources:
///     - function for creating popup adapted from https://www.youtube.com/watch?v=FgCIRMz_3dE
///
class magePopup: UIViewController {
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
    let deckArray = ["Magical-Bolt-Single", "Arcane-Burst-Single", "Voodoo-Doll-Single", "Spell-Tome-Single", "Mana-Potion-Single"]
    var loc = 0;
    
    ///shows the next card and updates the number of cards in the deck
    @IBAction func nextCard(_ sender: Any) {
        //print("NEXT")
        if(loc == 4)
        {
            loc = 0;
        }
        else
        {
            loc = loc+1;
        }
        if(loc == 0 || loc == 2 || loc == 4)
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
            loc = 4;
        }
        else
        {
            loc = loc-1;
        }
        if(loc == 0 || loc == 2 || loc == 4)
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


