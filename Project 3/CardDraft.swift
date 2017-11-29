//
//  CardDraft.swift
//  Project 3
//
//  Created by James Glass on 11/19/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

class CardDraft: UIViewController, iCarouselDataSource, iCarouselDelegate {
    var images = [String]()
    var selectArr = [Int]()
    var availableArr = [Int]()
    var tempCardArr = [String]()
    var draftTurn = playerStart
    var selected = Int()
    var countTurns = Int()
    
    @IBOutlet var viewCaro: iCarousel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var availableLabel: UILabel!
    @IBOutlet weak var howManyLabel: UILabel!
    
    var deck1 = Deck(name: "player1", deckArr: ["Empty"])
    var deck2 = Deck(name: "player2", deckArr: ["Empty"])
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return images.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        //Create a UI View
        let tempView = UIView(frame: CGRect(x: 0, y: 13, width: 253, height: 353))
        
        //Create a UIImageView
        let frame = CGRect(x: 0, y: 13, width: 253, height: 353)
        let imageView = UIImageView()
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFit
        
        //Set images to the imageView and add it to tempView
        //imageView.image = images[index]
        imageView.image = UIImage(named: images[index])
        tempView.addSubview(imageView)
        
        //Set Selected Label to display correct value
        //selectLabel.text = String(selectArr[viewCaro.currentItemIndex]) + " Selected"
        
        return tempView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing {
            return value * 1.2
        }
        return value
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        selectLabel.text = String(selectArr[viewCaro.currentItemIndex]) + " Selected"
        availableLabel.text = String(availableArr[viewCaro.currentItemIndex]) + " Available"
    }
    
    override func viewDidLoad() {
        
        if(playerStart == 1)
        {
            playerLabel.text = "PLAYER 2"
            
        }
        else if(playerStart == 2)
        {
            playerLabel.text = "PLAYER 1"
        }
        else
        {
            print("ERROR PICKING TURN")
        }
        
        if let test : AnyObject = UserDefaults.standard.object(forKey: "deck1") as AnyObject {
            let selectedDeck : [NSString] = test as! [NSString]
            deck1.deckArr = selectedDeck as [String]
        }
        if let test : AnyObject = UserDefaults.standard.object(forKey: "deck2") as AnyObject {
            let selectedDeck : [NSString] = test as! [NSString]
            deck2.deckArr = selectedDeck as [String]
        }
        
        images = ["Bad-Medicine-Single", "Health-Potion-Single", "Life-Steal-Single", "Brass-Knuckles-Single", "Throwing-Knife-Single", "Smoke-Bomb-Single", "Blacksmith-Single", "Spell-Tome-Single"]
        selectArr = [0, 0, 0, 0, 0, 0, 0, 0]
        availableArr = [4, 4, 4, 4, 4, 4, 4, 4]
        tempCardArr = ["Empty", "Empty"]
        selected = 0
        countTurns = 1
        viewCaro.isUserInteractionEnabled = true;
        viewCaro.reloadData()
        viewCaro.type = .rotary
    }
    
    class Deck {
        var name: String
        var deckArr: [String]
        init(name: String, deckArr: [String]) {
            self.name = name
            self.deckArr = deckArr
        }
    }
    
    func addCard(card: String) {
        var j = 0
        for i in 0...1 {
            if(tempCardArr[i] == "Empty" && j == 0) {
                tempCardArr[i] = card
                j = j + 1
            }
        }
    }
    
    func addDeck(currDeck: Deck) {
        var j = 0
        for i in 0...19 {
            if(currDeck.deckArr[i] == "Empty" && j == 0) {
                currDeck.deckArr[i] = tempCardArr[j]
                j = j + 1
            }
        }
        for i in 0...19 {
            if(currDeck.deckArr[i] == "Empty" && j == 1) {
                currDeck.deckArr[i] = tempCardArr[j]
                j = j + 1
            }
        }
        tempCardArr = ["Empty", "Empty"]
    }
    
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButtonPress(_ sender: Any) {
        if(selectArr[viewCaro.currentItemIndex] != 2 && availableArr[viewCaro.currentItemIndex] != 0 && selected != 2) {
            selectArr[viewCaro.currentItemIndex] = selectArr[viewCaro.currentItemIndex] + 1
            selected = selected + 1
            availableArr[viewCaro.currentItemIndex] = availableArr[viewCaro.currentItemIndex] - 1
            
            let cardName = images[viewCaro.currentItemIndex]
            let postfix = cardName.index(cardName.endIndex, offsetBy: -7)
            let truncate = cardName.substring(to: postfix)
    
            updateLabels()
            addCard(card: truncate+"-Deck")
            //addDeck(currDeck: deck1, card: truncate+"-Deck")
        }
        
    }
    
    func removeCard(card: String) {
        var j = 0
        for i in 0...1 {
            if(tempCardArr[i] == card && j == 0) {
                tempCardArr[i] = "Empty"
                j = j + 1
            }
        }
    }
    
    @IBOutlet weak var removeButton: UIButton!
    @IBAction func removeButtonPress(_ sender: Any) {
        if(selectArr[viewCaro.currentItemIndex] != 0 && selected != 0) {
            selectArr[viewCaro.currentItemIndex] = selectArr[viewCaro.currentItemIndex] - 1
            selected = selected - 1
            availableArr[viewCaro.currentItemIndex] = availableArr[viewCaro.currentItemIndex] + 1
            
            let cardName = images[viewCaro.currentItemIndex]
            let postfix = cardName.index(cardName.endIndex, offsetBy: -7)
            let truncate = cardName.substring(to: postfix)
            
            updateLabels()
            removeCard(card: truncate+"-Deck")
        }
    }
    
    func updateLabels() {
        selectLabel.text = String(selectArr[viewCaro.currentItemIndex]) + " Selected"
        availableLabel.text = String(availableArr[viewCaro.currentItemIndex]) + " Available"
        if(selected == 0) {
            howManyLabel.text = "PICK TWO CARDS"
        }
        else if(selected == 1) {
            howManyLabel.text = "PICK ONE MORE CARD"
        }
        else if(selected == 2) {
            howManyLabel.text = "NO MORE CARDS TO PICK"
        }
    }
    
    @IBOutlet weak var endTurnButton: UIButton!
    @IBAction func endTurnButtonPress(_ sender: Any) {
        if(draftTurn == 1 && selected == 2 && countTurns != 12) {
            draftTurn = 2
            playerLabel.text = "PLAYER 1"
            //add cards from temp card array to deck
            addDeck(currDeck: deck1)
            selected = 0
            selectArr = [0, 0, 0, 0, 0, 0, 0, 0]
            selectLabel.text = "0 Selected"
            howManyLabel.text = "PICK TWO CARDS"
            countTurns = countTurns + 1
        }
        else if(draftTurn == 2 && selected == 2 && countTurns != 12) {
            draftTurn = 1
            playerLabel.text = "PLAYER 2"
            //add cards from temp card array to deck
            addDeck(currDeck: deck2)
            selected = 0
            selectArr = [0, 0, 0, 0, 0, 0, 0, 0]
            selectLabel.text = "0 Selected"
            howManyLabel.text = "PICK TWO CARDS"
            countTurns = countTurns + 1
        }
        else if(countTurns == 12 && selected == 2) {
            if(draftTurn % 2 == 1) {
                addDeck(currDeck: deck1)
            }
            else {
                addDeck(currDeck: deck2)
            }
            print("DRAFT COMPLETE")
            let defaults = UserDefaults.standard
            defaults.set(deck1.deckArr, forKey: "draftedDeck1")
            let defaults2 = UserDefaults.standard
            defaults2.set(deck2.deckArr, forKey: "draftedDeck2")
            performSegue(withIdentifier: "completeDraft", sender: nil)
        }
        else {
            print("Error")
        }
    }
    
    
    @IBAction func menuPressed(_ sender: Any) {
        let popup = UIStoryboard(name: "GamePlayingScreen", bundle: nil).instantiateViewController(withIdentifier: "menuPopupID") as! menuPopup
        self.addChildViewController(popup)
        popup.view.frame = self.view.frame
        self.view.addSubview(popup.view)
        popup.didMove(toParentViewController: self)
    }
}
