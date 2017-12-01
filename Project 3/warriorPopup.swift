//
//  warriorPopup.swift
//  Project 3
//
//  Created by Dylan Herrig on 11/23/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//



import Foundation
import UIKit

/// warriorPopup class that pops up an overlay that displays the warrior cards
/// - Sources:
///     - function for creating popup adapted from https://www.youtube.com/watch?v=FgCIRMz_3dE
/// 
class warriorPopup: UIViewController {
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
    
    let deckArray = ["Sword-Strike-Single", "Double-Edge-Single", "Disarm-Single", "Blacksmith-Single", "Liquid-Courage-Single",]
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


