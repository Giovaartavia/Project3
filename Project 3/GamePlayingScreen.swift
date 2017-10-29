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
    
    class Player
    {
        //fighting and psychic are different for class
        let mageDeck = ["Lifesteal", "Lifesteal","Mana Potion","Mana Potion","Mana Potion","Voodoo Doll", "Voodoo Doll", "Disarm", "Disarm", "Spell Tome", "Smoke Bomb", "Smoke Bomb", "Arcane Burst", "Health Potion", "Health Potion", "Bad Medicine", "Bad Medicine", "Magical Bolt", "Magical Bolt", "Magical Bolt"]
        //var currDeck = ["Lifesteal", "Lifesteal","Mana Potion","Mana Potion","Mana Potion","Voodoo Doll", "Voodoo Doll", "Disarm", "Disarm", "Spell Tome", "Smoke Bomb", "Smoke Bomb", "Arcane Burst", "Health Potion", "Health Potion", "Bad Medicine", "Bad Medicine", "Magical Bolt", "Magical Bolt", "Magical Bolt"].shuffled()
        var currDeck = ["Brass Knuckles", "Lifesteal", "Voodoo Doll", "Lifesteal", "Bad Medicine", "Lifesteal" ]
        var currStamina = 2
        var totalStamina = 2
        var health = 20
        var attack = 0
        var buffArr: [String] = []
        var debuff = ""
        var debuffTime = 0
        var shuffleCount = 2
        
        //debuffs
        var canHeal = true
        var hasAttacked = false
        var canAddBack = true
        var bloodThinner = false
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
            print ("Current stamina: ")
            print(currPlayer.currStamina)
            
            //TODO: remove print statements 
            switch currCard
            {
                
                //buffs (INFINITE)  
            //+1 attack per turn      
            case "Mana Potion", "Liquid Courage":
                addBuff(newBuff: currCard, currPlayer: currPlayer)
                print("Steel")
            //+3 attack once while active
            case "Spell Tome", "Blacksmith":
            addBuff(newBuff: currCard, currPlayer: currPlayer)
                print("Dark")
            //+2 health per turn
            case "Health Potion":
            addBuff(newBuff: currCard, currPlayer: currPlayer)
                print("Plasma")
                
                //debuff (LASTS 2 TURNS)
                
            //subtract 2 ATK from opponent for 1st attack each turn
            case "Disarm":
                nextPlayer.debuff = "Disarm"
                nextPlayer.debuffTime = 2
                print("Grass")
                
            //Stops Opponent from healing
            case "Bad Medicine":
                nextPlayer.debuff = "Bad Medicine"
                nextPlayer.debuffTime = 2
                print("Bad Medicine")
                
            //1 damage to opponent
                //mage: Opponent cannot use move card option
            case "Voodoo Doll":
                nextPlayer.debuff = "Voodoo Doll"
                nextPlayer.debuffTime = 2
                nextPlayer.health -= 1
                currPlayer.hasAttacked = true
                print("Voodoo Doll")
                //warrior: Opponent takes 2 damage per turn
            case "Brass Knuckles":
                nextPlayer.debuff = "Brass Knuckles"
                nextPlayer.debuffTime = 2
                nextPlayer.health -= 1
                currPlayer.hasAttacked = true
                print("Brass Knuckles")
                
                // single turn
            //Places top card of opponents deck on the bottom
            case "Smoke Bomb":
                addToBack(arr: &nextPlayer.currDeck)
                print("Smoke Bomb")
            //Does your own atk stat damage to yourself, then (atk * 2) + 2 to opponent.
            case "Arcane Burst", "Double Edge":
                currPlayer.health -= currPlayer.attack
                currPlayer.hasAttacked = true
                nextPlayer.health -= ((currPlayer.attack * 2) + 2)
                selfDamage = true
                print("Arcane Burst/Double Edge")
            //Does atk + 2 to opponent.
            case "Magical Bolt", "Sword Strike":
                nextPlayer.health -= (currPlayer.attack + 2)
                currPlayer.hasAttacked = true
                print("Magical Bolt/Sword Strike")
                currPlayer.hasAttacked = true
            //Do 1 damage, regain 3 hp.
            case "Lifesteal":
                if(currPlayer.canHeal)
                {
                    currPlayer.health += 3
                    print("Lifesteal")
                }
                nextPlayer.health -= 1
                currPlayer.hasAttacked = true
                print("Healing did not happen because debuff was active")

            //Do 1 damage, regain 2 stamina.
            case "Throwing Knife":
                currPlayer.currStamina += 2
                nextPlayer.health -= 1
                currPlayer.hasAttacked = true
                print("Throwing Knife")
                
            default: //Necessary
                print("Error in card selection switch case")
            }
            checkDebuff(currPlayer: currPlayer, nextPlayer: nextPlayer)
            addToBack(arr: &currPlayer.currDeck)
            
        }
        else
        {
            print("NOT ENOUGH STAMINA HONEY!")
        }
        
        //check to see if player has lost
        //check if self damage occured and check attacking player health first
    }

    func addBuff(newBuff: String, currPlayer: Player)
    {
        //check buff array
        if(currPlayer.buffArr.count == 3)
        {
            //change front 
            currPlayer.buffArr[0] = newBuff
            //move to back 
            addToBack(arr: &currPlayer.currDeck)         
        }
        else if(currPlayer.buffArr.count >= 0 && currPlayer.buffArr.count < 3)
        {
            //append to end
            currPlayer.buffArr.append(newBuff)
        }
        else
        {
            print("Error in add buff")
        }
    } 

    //TODO: Complete function check for these cards existing in the player buff array
    func checkBuffs(currPlayer: Player)
    {
        for i in 0...(currPlayer.buffArr.count-1)
        {
            let buffCard = currPlayer.buffArr[i]
            switch buffCard
            {
            case "Mana Potion", "Liquid Courage":
                print("Steel")
            //+3 attack once while active
            case "Spell Tome", "Blacksmith":
                print("Dark")
            //+2 health per turn
            case "Health Potion":
                print("Plasma")
            default:
                print("Error inside checkBuffs")
            }
        }
    }
    
    func checkDebuff(currPlayer: Player, nextPlayer: Player)
    {
        if(currPlayer.debuff == "Disarm")
        {
            if(!currPlayer.hasAttacked)
            {
                currPlayer.attack -= 2
            }
        }
        else if(currPlayer.debuff == "Bad Medicine")
        {
            currPlayer.canHeal = false
        }
        else if(currPlayer.debuff == "Voodoo Doll")
        {
            currPlayer.canAddBack = false
        }
        else if(currPlayer.debuff == "Brass Knuckles")
        {
            currPlayer.bloodThinner = true
        }
    }

    // Place card to bottom and updates stamina
    func placeBottom(currPlayer: Player)
    {
        if (currPlayer.currStamina >= 1)
        {
            checkDebuff(currPlayer: currPlayer, nextPlayer: currPlayer)
            if(currPlayer.canAddBack)
            {
                currPlayer.currStamina -= 1
                print(currPlayer.currDeck)
                addToBack(arr: &currPlayer.currDeck)
                print(currPlayer.currDeck)
            }
            else
            {
                print("Action not performed because Voodoo Doll debuff is active")
            }
        }
        else
        {
            print("NOT ENOUGH STAMINA HONEY!")
        }
    }
    
    //Updates player's stamina upon ending turn. Checks buffs and debuffs.
    func endTurn(currPlayer: Player, nextPlayer: Player)
    {
        if(currPlayer.totalStamina != 10)
        {
            currPlayer.totalStamina += 2
        }
        currPlayer.currStamina = currPlayer.totalStamina
        
        checkDebuff(currPlayer: currPlayer, nextPlayer: nextPlayer)
        
        if(nextPlayer.bloodThinner)
        {
            nextPlayer.health -= 2
        }
        
        //Keep track of debuff. Debuff can only live for 2 back-and-forth turns.
        if(nextPlayer.debuff != "")
        {
            nextPlayer.debuffTime -= 1
            if (nextPlayer.debuffTime == 0)
            {
                nextPlayer.debuff = ""
                nextPlayer.bloodThinner = false
                nextPlayer.canHeal = true
                nextPlayer.canAddBack = true
            }
        }
        currPlayer.hasAttacked = false
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

    //TEST PRINTS. Prints all stats
    func printStats()
    {
        print("*********STATS*********")
        print ("Player 1's current stats: ")
        print ("Current Stamina: \(player1.currStamina)")
        print ("Total Stamina: \(player1.totalStamina)")
        print ("HP: \(player1.health)")
        print ("Attack: \(player1.attack)")
        print ("Buffs: \(player1.buffArr)")
        print ("Debuff: \(player1.debuff)")
        print ("Shuffles: \(player1.shuffleCount)")
        
        print("========================")
        
        print ("Player 2's current stats: ")
        print ("Current Stamina: \(player2.currStamina)")
        print ("Total Stamina: \(player2.totalStamina)")
        print ("HP: \(player2.health)")
        print ("Attack: \(player2.attack)")
        print ("Buffs: \(player2.buffArr)")
        print ("Debuff: \(player2.debuff)")
        print ("Shuffles: \(player2.shuffleCount)")
        print ("******END OF STATS*****")
        
        printTopCard()
    }
    
    func printTopCard()
    {
        print ("Player 1's current top card: \(player1.currDeck[0])")
        print ("Player 2's current top card: \(player2.currDeck[0])")
    }
    
    // END OF FUNCTIONS
    
    let player1 = Player()
    let player2 = Player()

    //turn for testing always starts on player 1
    var turn = 1;


    //Button Press Actions
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
        
        //TEST. Show stats
        printStats()
        
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
        
        //TEST. Show stats
        printStats()
    }
    
    //Changes whose turn it is. 1 is player 1. 2 is player 2.
    //Also replenishes stamina, updates total stamina, and checks for buffs/debuffs
    @IBAction func endTurnPress(_ sender: Any) {
        if(turn == 1)
        {
            turn = 2
            endTurn(currPlayer: player1, nextPlayer: player2)
        }
        else if(turn == 2)
        {
            turn = 1
            endTurn(currPlayer: player2, nextPlayer: player1)
        }
        else
        {
            print("Error inside endTurnPress!")
        }
        
        //TEST. Show stats
        printStats()
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
        
        //TEST. Show stats
        printStats()
    }
    @IBAction func surrenderPress(_ sender: Any) {
    }
}

