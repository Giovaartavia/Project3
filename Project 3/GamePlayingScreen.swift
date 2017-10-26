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
    class Mage
    {
        //fighting and psychic are different for class
        let mageDeck = ["mFighting", "mFighting","mSteel","mSteel","mSteel","mPsychic", "mPsychic", "mGrass", "mGrass", "mDark", "mFairy", "mFairy", "mLightning", "mPlasma", "mPlasma", "mWater", "mWater", "mFire", "mFire", "mFire"]
        var currDeck = ["mFighting", "mFighting","mSteel","mSteel","mSteel","mPsychic", "mPsychic", "mGrass", "mGrass", "mDark", "mFairy", "mFairy", "mLightning", "mPlasma", "mPlasma", "mWater", "mWater", "mFire", "mFire", "mFire"].shuffled()
        var currStamina = 2
        var totalStamina: Int?
        var health = 20
        var attack = 0
        var buffArr: [String]?
        var debuff: String?
        var debuffTime = 0
        var shuffleCount = 2
        
    }
    
    class Warrior
    {
        //fighting and psychic are different for class
        let warriorDeck = ["wFighting", "wFighting","wSteel","wSteel","wSteel","wPsychic", "wPsychic", "wGrass", "wGrass", "wDark", "wFairy", "wFairy", "wLightning", "wPlasma", "wPlasma", "wWater", "wWater", "wFire", "wFire", "wFire"]
        var currDeck = ["wFighting", "wFighting","wSteel","wSteel","wSteel","wPsychic", "wPsychic", "wGrass", "wGrass", "wDark", "wFairy", "wFairy", "wLightning", "wPlasma", "wPlasma", "wWater", "wWater", "wFire", "wFire", "wFire"].shuffled()
        var currStamina = 2
        var totalStamina: Int?
        var health = 20
        var attack = 0
        var buffArr: [String]?
        var debuff: String?
        var debuffTime = 0
        var shuffleCount = 2
        
        
    }
    
    //Adds first element from array to back of array
    func addToBack(arr: inout [String]){
        let tempFirstElement = arr[0]
        arr.remove(at: 0)
        arr.append(tempFirstElement)
    }
    
    let player1 = Mage()
    let player2 = Warrior()

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
            
        }
        else if(turn == 2)
        {
            
        }
        else
        {
            print("error in playCardPress")
        }
        
        //check stamina
        if(player1.currStamina >= 2)
        {
            //decrease stamina
            player1.currStamina -= 2
            //check card played and update
            
            var currCard = player1.currDeck[0]
            var selfDamage = false
            
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
                player1.debuff = "mGrass"
                player1.debuffTime = 0
                print("Grass")
            case "wGrass":
                player1.debuff = "wGrass"
                player1.debuffTime = 0
                print("Grass")
            
            //Stops Opponent from healing
            case "mWater":
                player1.debuff = "mWater"
                player1.debuffTime = 0
                print("Water")
            case "wWater":
                player1.debuff = "wWater"
                player1.debuffTime = 0
                print("Water")
                
            //1 damage to opponent
            //mage: Opponent cannot use move card option
            //warrior: Opponent takes 2 damage per turn
            case "mPsychic":
                player1.debuff = "mPsychic"
                player1.debuffTime = 0
                print("mPsychic")
            case "wPsychic":
                player1.debuff = "wPsychic"
                player1.debuffTime = 0
                print("wPsychic")
                
            // single turn
            case "mFairy", "wFairy":
                //call on function from button to move to bottom
                print("Fairy")
            case "mLightning", "wLightning":
                player1.health -= player1.attack
                player2.health -= ((player1.attack * 2) + 2)
                selfDamage = true
                print("Lightning")
            case "mFire", "wFire":
                player2.health -= (player1.attack + 2)
                print("Fire")
            case "mFighting":
                player1.health += 3
                player2.health -= 1
                /*
                print("mFighting")
                print(player1.health)
                print(player2.health)
                print(player1.currStamina)
                 */
            case "wFighting":
                player1.currStamina += 2
                player2.health -= 1
                print("wFighting")

            default: //Necessary
                print("Error in card selection switch case")
                
            }
            
        }
        else
        {
            print("NOT ENOUGH STAMINA HONEY!")
        }
        
        //check to see if player has lost
        //check if self damage occured and check attacking player health first
        
        
    }
    @IBAction func placeBottomPress(_ sender: Any) {
        
        if (turn == 1)
        {
            if (player1.currStamina >= 1)
            {
                //check if mage debuff is active
                player2.currStamina -= 1
                print(player1.currDeck)
                addToBack(arr: &player1.currDeck)
                print(player1.currDeck)
            }
            else
            {
                print("NOT ENOUGH STAMINA HONEY!")
            }
        }
        else
        {
            if (player2.currStamina >= 1)
            {
                //check if mage debuff is active
                player2.currStamina -= 1
                print(player2.currDeck)
                addToBack(arr: &player2.currDeck)
                print(player2.currDeck)
            }
            else
            {
                print("NOT ENOUGH STAMINA HONEY!")
            }
        }
    }
    @IBAction func endTurnPress(_ sender: Any) {
    }
    @IBAction func shufflePress(_ sender: Any) {
    }
    @IBAction func surrenderPress(_ sender: Any) {
    }
}

