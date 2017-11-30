//
//  goblinPopup.swift
//  Project 3
//
//  Created by Dylan Herrig on 11/23/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

class goblinPopup: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    @IBOutlet weak var numInDeck: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    let deckArray = ["Horde-Ransack-Single", "Loot-Tool-Single", "Goblin-Greed-Single", "Sleight-of-Hand-Single", "Handy-Discount-Single", "Money-is-Power-Single", "Coin-Craze-Single"];
    var loc = 0;
    
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


