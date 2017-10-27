//
//  PlsWork.swift
//  Project 3
//
//  Created by Giovanni on 10/24/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

// Beginning of code from https://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

//end of adapted code

class ViewPlayGame: UIViewController {
    
    @IBOutlet weak var metal: UIImageView!
    class Player
    {
        //fighting and psychic are different for class
        let mageDeck = ["mFighting", "mFighting","mSteel","mSteel","mSteel","mPsychic", "mPsychic", "mGrass", "mGrass", "mDark", "mFairy", "mFairy", "mLightning", "mPlasma", "mPlasma", "mWater", "mWater", "mFire", "mFire", "mFire"]
        var currDeck = ["mFighting", "mFighting","mSteel","mSteel","mSteel","mPsychic", "mPsychic", "mGrass", "mGrass", "mDark", "mFairy", "mFairy", "mLightning", "mPlasma", "mPlasma", "mWater", "mWater", "mFire", "mFire", "mFire"].shuffled()
        var currStamina = 2
        var totalStamina = 2
        var health = 20
        var attack = 0
        var buffArr: [String]?
        var debuff: String?
        var debuffTime = 0
        var shuffleCount = 2
        
    }
    
    //START OF FUNCTIONS
    
    //Adds first element from array to back of array
    func addToBack(arr: inout [String]){
        let tempFirstElement = arr[0]
        arr.remove(at: 0)
        arr.append(tempFirstElement)
    }
    
    //Contains all cards and their interactions
    func playCard(currPlayer: Player, nextPlayer: Player)
    {
        //check stamina
        if(currPlayer.currStamina >= 2)
        {
            //decrease stamina
            currPlayer.currStamina -= 2
            //check card played and update
            
            var currCard = currPlayer.currDeck[0]
            var selfDamage = false
            
            //Test print
            print(currPlayer.currStamina)
            
            //FIX THIS remove print statements
            switch currCard
            {
                
                //buffs (INFINITE)
                
            case "mSteel", "wSteel":
                print("Steel")
            case "mDark", "wDark":
                print("Dark")
            case "mPlasma", "wPlasma":
                print("Plasma")
                
                //debuff (LASTS 2 TURNS)
                
            //subtract 2 ATK from opponent for 1st attack each turn
            case "mGrass":
                currPlayer.debuff = "mGrass"
                currPlayer.debuffTime = 0
                print("Grass")
            case "wGrass":
                currPlayer.debuff = "wGrass"
                currPlayer.debuffTime = 0
                print("Grass")
                
            //Stops Opponent from healing
            case "mWater":
                currPlayer.debuff = "mWater"
                currPlayer.debuffTime = 0
                print("Water")
            case "wWater":
                currPlayer.debuff = "wWater"
                currPlayer.debuffTime = 0
                print("Water")
                
                //1 damage to opponent
                //mage: Opponent cannot use move card option
            //warrior: Opponent takes 2 damage per turn
            case "mPsychic":
                currPlayer.debuff = "mPsychic"
                currPlayer.debuffTime = 0
                print("mPsychic")
            case "wPsychic":
                currPlayer.debuff = "wPsychic"
                currPlayer.debuffTime = 0
                print("wPsychic")
                
            // single turn
            case "mFairy", "wFairy":
                //call on function from button to move to bottom
                print("Fairy")
            case "mLightning", "wLightning":
                currPlayer.health -= currPlayer.attack
                nextPlayer.health -= ((currPlayer.attack * 2) + 2)
                selfDamage = true
                print("Lightning")
            case "mFire", "wFire":
                nextPlayer.health -= (currPlayer.attack + 2)
                print("Fire")
            case "mFighting":
                currPlayer.health += 3
                nextPlayer.health -= 1
                /*
                 print("mFighting")
                 print(player1.health)
                 print(player2.health)
                 print(player1.currStamina)
                 */
            case "wFighting":
                currPlayer.currStamina += 2
                nextPlayer.health -= 1
                print("wFighting")
                
            default: //Necessary
                print("Error in card selection switch case")
            }
            addToBack(arr: &currPlayer.currDeck)
            
        }
        else
        {
            print("NOT ENOUGH STAMINA HONEY!")
        }
        
        //check to see if player has lost
        //check if self damage occured and check attacking player health first
    }
    
    // Place card to bottom and updates stamina
    func placeBottom(currPlayer: Player)
    {
        if (currPlayer.currStamina >= 1)
        {
            //TODO: check if mage debuff is active
            currPlayer.currStamina -= 1
            print(currPlayer.currDeck)
            addToBack(arr: &currPlayer.currDeck)
            print(currPlayer.currDeck)
        }
        else
        {
            print("NOT ENOUGH STAMINA HONEY!")
        }
    }
    
    //Updates player's stamina upon ending turn
    func endTurn(currPlayer: Player)
    {
        if(currPlayer.totalStamina != 10)
        {
            currPlayer.totalStamina += 2
        }
        currPlayer.currStamina = currPlayer.totalStamina
    }
    
    //Shuffles current deck if applicable
    func shuffleCards(currPlayer: Player)
    {
        if (currPlayer.shuffleCount > 0)
        {
            currPlayer.shuffleCount -= 1
            currPlayer.currDeck.shuffle()
        }
        else
        {
            print("No more shuffles!")
        }
    }
    
    // END OF FUNCTIONS
    
    let player1 = Player()
    let player2 = Player()

    //turn for testing always starts on player 1
    var turn = 1;

    @IBOutlet weak var playCardButton: UIButton!
    @IBOutlet weak var placeBottomButton: UIButton!
    @IBOutlet weak var endTurnButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var surrenderButton: UIButton!
    
    
    @IBAction func playCardPress(_ sender: Any) {
        
        //check turn
        if(turn == 1)
        {
            playCard(currPlayer: player1, nextPlayer: player2)
        }
        else if(turn == 2)
        {
            playCard(currPlayer: player2, nextPlayer: player1)
        }
        else
        {
            print("error in playCardPress")
        }
        
    }
    @IBAction func placeBottomPress(_ sender: Any) {
        
        if (turn == 1)
        {
            placeBottom(currPlayer: player1)
        }
        else if (turn == 2)
        {
            placeBottom(currPlayer: player1)
        }
        else
        {
            print("Error inside placeButtomPress")
        }
    }
    
    //Changes whose turn it is. 1 is player 1. 2 is player 2.
    //Also replenishes stamina, updates total stamina, and checks for buffs/debuffs
    @IBAction func endTurnPress(_ sender: Any) {
        if(turn == 1)
        {
            turn = 2
            endTurn(currPlayer: player1)
            
            //TEST PRINTS
            print ("Player 2's turn. Player 2's current stamina: ")
            print (player2.currStamina)
            print (player2.totalStamina)
                
            print ("Player 1's stamina has been updated:")
            print (player1.currStamina)
            print (player1.totalStamina)
        }
        else if(turn == 2)
        {
            turn = 1
            endTurn(currPlayer: player2)
            
            //TEST PRINTS
            print ("Player 1's turn. Player 1's current stamina: ")
            print (player1.currStamina)
            print (player1.totalStamina)
            
            print ("Player 2's stamina has been updated:")
            print (player2.currStamina)
            print (player2.totalStamina)
        }
        else
        {
            print("Error inside endTurnPress!")
        }
    }
    
    //Shuffles current player's deck if they have shuffles left
    @IBAction func shufflePress(_ sender: Any) {
        if (turn == 1)
        {
            shuffleCards(currPlayer: player1)
        }
        else if (turn == 2)
        {
            shuffleCards(currPlayer: player2)
        }
        else
        {
            print ("Error inside shufflePress!")
        }
    }
    @IBAction func surrenderPress(_ sender: Any) {
    }
}

