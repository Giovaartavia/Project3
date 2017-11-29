//
//  magePopup.swift
//  Project 3
//
//  Created by Dylan Herrig on 11/23/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

class magePopup: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    
    
    
    @IBOutlet weak var numInDeck: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    let deckArray = ["Magical-Bolt-Single", "Arcane-Burst-Single", "Voodoo-Doll-Single", "Spell-Tome-Single", "Mana-Potion-Single"]
    var loc = 0;
    
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


