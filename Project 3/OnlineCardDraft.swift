//
//  OnlineCardDraft.swift
//  Project 3
//
//  Created by Brandon Lammey on 11/20/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

/// Class that calls and creates a carrousel to select neutral cards.
class OnlineCardDraft: UIViewController, iCarouselDataSource, iCarouselDelegate {
    /// Array of card image strings
    var images = [String]()
    /// Array of selected cards so far.
    var selectArr = [Int]() //cards selected
     /// Array of cards are still available to be chosen.
    var availableArr = [Int]() //cards available
    /// Temporary array of cards that holds which cards a player has selected in a single turn. Resets after endTurn is pressed.
    var tempCardArr = [String]()
    /// Player's turn to pick 2 cards.
    var draftTurn = playerStart
    /// Contains the amount of selected cards a player has in a turn. There has to be 2 cards selected in order to pass the turn and the maximum amount of selected cards is 2.
    var selected = Int()
    /// Amounts of turns that have been played on card select. They increment by 1 every time endTurn is pressed. Starts at 1 and ends at 12.
    var countTurns = Int()
    
    ///iCarousel object
    @IBOutlet var viewCaro: iCarousel!
    ///label that tells us which player is drafting
    @IBOutlet weak var playerLabel: UILabel!
    ///label that tells us how many cards are selected of a given type
    @IBOutlet weak var selectLabel: UILabel!
    ///label that tells us how many cards are available to select of a given type
    @IBOutlet weak var availableLabel: UILabel!
    ///label that tells the player how many more cards to draft
    @IBOutlet weak var howManyLabel: UILabel!
    
    var deck1 = Deck(name: "player1", deckArr: ["Empty"])
    var deck2 = Deck(name: "player2", deckArr: ["Empty"])
    
    //multipeer connectivity manager
    let screenService = ScreenServiceManager()
    
    /// Returns the number of items in the carousel.
    /// - Parameters:
    ///   - in carousel: Carousel object of type iCarousel.
    func numberOfItems(in carousel: iCarousel) -> Int {
        return images.count
    }
    
    /// Creates a ui image view and sets images to the view
    ///
    /// - Parameters:
    ///   - carousel: Player Object who is executing their turn
    ///   - viewForItemAt index: Player Object who is not executing their turn
    ///   - reusing view: Player Object who is not executing their turn
    ///
    /// - Return: A UIView
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
    
    /// Creates a ui image view and sets images to the view
    ///
    /// - Parameters:
    ///   - carousel: iCarousel object
    ///   - viewForItemAt index: Int value of item index
    ///   - reusing view: Reused UIView
    ///
    /// - Return: A UIView
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing {
            return value * 1.2
        }
        return value
    }
   
    /// Sets the spacing inbetween carousel images
    ///
    /// - Parameters:
    ///   - carousel: iCarousel object
    ///   - valueFor option: option for the selected iCarousel
    ///   - withDefault value: CGFloat value of iCarousel
    ///
    /// - Return: CGFloat value
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        selectLabel.text = String(selectArr[viewCaro.currentItemIndex]) + " Selected"
        availableLabel.text = String(availableArr[viewCaro.currentItemIndex]) + " Available"
    }
    
    /// This function is called once the Card Draft is loaded.
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
        
        if let test : AnyObject = UserDefaults.standard.object(forKey: "deck1") as Optional {
            let selectedDeck : [NSString] = test as! [NSString]
            deck1.deckArr = selectedDeck as [String]
        }
        if let test : AnyObject = UserDefaults.standard.object(forKey: "deck2") as Optional {
            let selectedDeck : [NSString] = test as! [NSString]
            deck2.deckArr = selectedDeck as [String]
        }
        
        images = ["Bad-Medicine-Single", "Health-Potion-Single", "Life-Steal-Single", "Brass-Knuckles-Single", "Throwing-Knife-Single", "Smoke-Bomb-Single", "Haunt-Taunt-Single"]
        selectArr = [0, 0, 0, 0, 0, 0, 0]
        availableArr = [4, 4, 4, 4, 4, 4, 4]
        tempCardArr = ["Empty", "Empty"]
        selected = 0
        countTurns = 1
        viewCaro.isUserInteractionEnabled = true;
        viewCaro.reloadData()
        viewCaro.type = .rotary
        //self.view bringSubviewToFront:addButton
        

        super.viewDidLoad()
        screenService.delegate = self
    }
    
    /// Deck Object
    /// Object includes a deck array and name
    ///
    /// - Parameters:
    ///   - name: Player's name. For now just "player1" or "player2"
    ///   - deckArr: Stores the deck of each player
    class Deck {
        var name: String
        var deckArr: [String]
        init(name: String, deckArr: [String]) {
            self.name = name
            self.deckArr = deckArr
        }
    }
    
    /// Adds the selected card to a temporary array
    /// Searchs for an "Empty" and replaces it with the name of the card
    ///
    /// - Parameters:
    ///   - card: card to be added to the temporary array
    func addCard(card: String) {
        var j = 0
        for i in 0...1 {
            if(tempCardArr[i] == "Empty" && j == 0) {
                tempCardArr[i] = card
                j = j + 1
            }
        }
    }
    
    /// Adds the two selected cards to either player 1 or 2's deck
    /// Searchs for two "Empty"s and replaces them with the names of the cards
    ///
    /// - Parameters:
    ///   - card: card to be added to the temporary array
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
    
    ///Outlet for the add card button
    @IBOutlet weak var addButton: UIButton!
    
    /// Checks if the player can add any more cards or not
    /// If so, calls addCard, updates labels, and updates selected/available array values
    ///
    /// - Parameters:
    ///   - sender: Player pressing button
    @IBAction func addButtonPress(_ sender: Any) {
        if(selectArr[viewCaro.currentItemIndex] != 2 && availableArr[viewCaro.currentItemIndex] != 0 && selected != 2)
        {
            let name = "addCard." + String(viewCaro.currentItemIndex)
            screenService.send(screenName: name)
            
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
    
    /// Removes a card from the temporary card array
    /// Searches for card name and replaces with an "Empty"
    ///
    /// - Parameters:
    ///   - card: card to be removed from temp array
    func removeCard(card: String) {
        var j = 0
        for i in 0...1 {
            if(tempCardArr[i] == card && j == 0) {
                tempCardArr[i] = "Empty"
                j = j + 1
            }
        }
    }
    
    ///Outlet for the remove card button
    @IBOutlet weak var removeButton: UIButton!
    
    /// Checks if the player can remove any more cards or not
    /// If so, calls removeCard, updates labels, and updates selected/available array values
    ///
    /// - Parameters:
    ///   - sender: Player pressing button
    @IBAction func removeButtonPress(_ sender: Any)
    {
        if(selectArr[viewCaro.currentItemIndex] != 0 && selected != 0)
        {
            screenService.send(screenName: "removeCard")
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
    
    /// Updates card selection on carrousel 
    /// - Parameters:
    ///   - command: string received which determines
    ///     the player deck to be modified
    func updateCardSelectionOnline(command: String)
    {
        var newDeckArray = command.components(separatedBy: ".")
        let position = Int(newDeckArray[1])!
        switch newDeckArray[0] {
        case "removeCard":
            selectArr[position] = selectArr[position] - 1
            selected = selected - 1
            availableArr[position] = availableArr[position] + 1
            
            let cardName = images[position]
            let postfix = cardName.index(cardName.endIndex, offsetBy: -7)
            let truncate = cardName.substring(to: postfix)
    
            removeCard(card: truncate+"-Deck")
        case "addCard":
            selectArr[position] = selectArr[position] + 1
            selected = selected + 1
            availableArr[position] = availableArr[position] - 1
            
            let cardName = images[position]
            let postfix = cardName.index(cardName.endIndex, offsetBy: -7)
            let truncate = cardName.substring(to: postfix)
            
            addCard(card: truncate+"-Deck")
            
        default:
            NSLog("%@", "Unknown value received: \(command)")
        }
        
    }
    
    ///Updates all of the labels on the card drafting screen besides the Player Turn label
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
    
    ///Outlet for the end turn button
    @IBOutlet weak var endTurnButton: UIButton!
    
    /// Checks if the player has selected two cards, what turn it currently is, and how many turns have passed
    /// If player one's turn, go to player two's and vice versa
    /// If the number of turns is 12, take steps to end the drafting phase
    /// This calls to updateLabels, and resets all of the selected values for the next player's turn
    ///
    /// - Parameters:
    ///   - sender: Player pressing button
    @IBAction func endTurnButtonPress(_ sender: Any) {
        if(draftTurn == 1 && selected == 2 && countTurns != 12) {
            screenService.send(screenName: "Player1Turn")
            draftTurn = 2
            playerLabel.text = "PLAYER 1"
            //add cards from temp card array to deck
            addDeck(currDeck: deck1)
            selected = 0
            selectArr = [0, 0, 0, 0, 0, 0, 0, 0]
            selectLabel.text = "0 Selected"
            howManyLabel.text = "PICK TWO CARDS"
            countTurns = countTurns + 1
            availableLabel.text = String(availableArr[viewCaro.currentItemIndex]) + " Available"
        }
        else if(draftTurn == 2 && selected == 2 && countTurns != 12) {
            screenService.send(screenName: "Player2Turn")
            draftTurn = 1
            playerLabel.text = "PLAYER 2"
            //add cards from temp card array to deck
            addDeck(currDeck: deck2)
            selected = 0
            selectArr = [0, 0, 0, 0, 0, 0, 0, 0]
            selectLabel.text = "0 Selected"
            howManyLabel.text = "PICK TWO CARDS"
            countTurns = countTurns + 1
            availableLabel.text = String(availableArr[viewCaro.currentItemIndex]) + " Available"
        }
        else if(countTurns == 12 && selected == 2) {
            if(draftTurn % 2 == 1) {
                screenService.send(screenName: "Player1Final")
                addDeck(currDeck: deck1)
                availableLabel.text = String(availableArr[viewCaro.currentItemIndex]) + " Available"
            }
            else {
                screenService.send(screenName: "Player2Final")
                addDeck(currDeck: deck2)
                availableLabel.text = String(availableArr[viewCaro.currentItemIndex]) + " Available"
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
    
    /// Updates player deck and selected cards for drafting
    /// - Parameters:
    ///   - command: string received which determines
    ///     the player deck to be modified
    func endTurnPressOnline(command: String)
    {
        switch command
        {
        case "Player1Turn":
                draftTurn = 2
                playerLabel.text = "PLAYER 1"
                //add cards from temp card array to deck
                addDeck(currDeck: deck1)
                selected = 0
                selectArr = [0, 0, 0, 0, 0, 0, 0, 0]
                selectLabel.text = "0 Selected"
                howManyLabel.text = "PICK TWO CARDS"
                countTurns = countTurns + 1
            
        case "Player2Turn":
                draftTurn = 1
                playerLabel.text = "PLAYER 2"
                //add cards from temp card array to deck
                addDeck(currDeck: deck2)
                selected = 0
                selectArr = [0, 0, 0, 0, 0, 0, 0, 0]
                selectLabel.text = "0 Selected"
                howManyLabel.text = "PICK TWO CARDS"
                countTurns = countTurns + 1
        case "Player1Final" :
            addDeck(currDeck: deck1)
            print("DRAFT COMPLETE")
            let defaults = UserDefaults.standard
            defaults.set(deck1.deckArr, forKey: "draftedDeck1")
            let defaults2 = UserDefaults.standard
            defaults2.set(deck2.deckArr, forKey: "draftedDeck2")
            performSegue(withIdentifier: "completeDraft", sender: nil)
        case "Player2Final" :
            addDeck(currDeck: deck2)
            print("DRAFT COMPLETE")
            let defaults = UserDefaults.standard
            defaults.set(deck1.deckArr, forKey: "draftedDeck1")
            let defaults2 = UserDefaults.standard
            defaults2.set(deck2.deckArr, forKey: "draftedDeck2")
            performSegue(withIdentifier: "completeDraft", sender: nil)

        default:
            NSLog("%@", "Unknown value received: \(command)")
        }
    }
    
    ///Button no longer used
    @IBAction func viewDeckPressed(_ sender: Any) {
        let popup = UIStoryboard(name: "OnlineGamePlayingScreen", bundle: nil)
        let viewController = popup.instantiateViewController(withIdentifier: ("onlineMenuPopupID")) as! OnlineMenuPopup
        self.addChildViewController(viewController)
        viewController.view.frame = self.view.frame
        self.view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
    }
    
}

///extends OnlineViewPLayGame to add in ScreenServiceManager MultiPeer functions
extension OnlineCardDraft : ScreenServiceManagerDelegate
{
    
    /// Empty function which recieves the names of connected devices to the MultiPeer session
    ///
    /// - Parameters:
    ///   - manager: ScreenServiceManager
    ///   - connectedDevices: Names of devices connected to
    func connectedDevicesChanged(manager: ScreenServiceManager, connectedDevices: [String])
    {
        OperationQueue.main.addOperation
            {
                //self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    
    /// Using commands recieved via screenString makes changes to recieving device
    ///
    /// - Parameters:
    ///   - manager: ScreenServiceManager
    ///   - screenString: String recieved from MultiPeer connected device
    func screenChanged(manager: ScreenServiceManager, screenString: String)
    {
        OperationQueue.main.addOperation
            {
                
                if(screenString.contains("Player1Turn") || screenString.contains("Player2Turn") || screenString.contains("Player1Final") || screenString.contains("Player2Final"))
                {
                    self.endTurnPressOnline(command: screenString)
                }
                else if(screenString.contains("addCard") || screenString.contains("removeCard"))
                {
                    self.updateCardSelectionOnline(command: screenString)
                }
                else
                {
                    NSLog("%@", "Unknown value received: \(screenString)")
                }
                
        }
    }
    
}
