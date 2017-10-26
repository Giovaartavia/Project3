//
//  PlsWork.swift
//  Project 3
//
//  Created by Giovanni on 10/24/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

class ViewPlayGame: UIViewController {
    @IBOutlet weak var metal: UIImageView!
    class Mage
    {
        //fighting and psychic are different for class
        let mageDeck = ["mFighting", "mFighting","mSteel","mSteel","mSteel","mPsychic", "mPsychic", "mGrass", "mGrass", "mDark", "mFairy", "mFairy", "mLightning", "mPlasma", "mPlasma", "mWater", "mWater", "mFire", "mFire", "mFire"]
        var currDeck = ["mFighting", "mFighting","mSteel","mSteel","mSteel","mPsychic", "mPsychic", "mGrass", "mGrass", "mDark", "mFairy", "mFairy", "mLightning", "mPlasma", "mPlasma", "mWater", "mWater", "mFire", "mFire", "mFire"] // FIX THIS should be deck to be created from mage deck array
        var currStamina = 2
        var totalStamina: Int?
        var health = 20
        var attack = 0
        var buffArr: [String]?
        var debuff: String?
        var shuffleCount = 2
        
        func getMageDeck() -> [String]{
            return mageDeck
        }
    }
    
    class Warrior
    {
        //fighting and psychic are different for class
        let warriorDeck = ["wFighting", "wFighting","wSteel","wSteel","wSteel","wPsychic", "wPsychic", "wGrass", "wGrass", "wDark", "wFairy", "wFairy", "wLightning", "wPlasma", "wPlasma", "wWater", "wWater", "wFire", "wFire", "wFire"]
        var currDeck: [String]?
        var currStamina = 2
        var totalStamina: Int?
        var health = 20
        var attack = 0
        var buffArr: [String]?
        var debuff: String?
        var shuffleCount = 2
    }
    
    let player1 = Mage()
    let player2 = Warrior()

    //turn for testing always starts on player 1
    var turn = 1;
    
    func deckShuffle(deck: [String]) -> [String]
    {
        //shuffle deck
        return deck
    }
    
    //var test = deckShuffle(deck: player1.getMageDeck())

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
            
            //FIX THIS remove print statements
            switch currCard
            {
            
            //buffs
            case "mSteel", "wSteel":
                print("Steel")
            case "mDark", "wDark":
                print("Dark")
            case "mPlasma", "wPlasma":
                print("Plasma")
            
            //debuff
                
            case "mGrass", "wGrass":
                print("Grass")
            case "mWater", "wWater":
                print("Water")
            case "mPsychic":
                print("mPsychic")
            case "wPsychic":
                print("wPsychic")
                
                
            case "mFairy", "wFairy":
                print("Fairy")
            case "mLightning", "wLightning":
                print("Lightning")
            case "mFire", "wFire":
                print("Fire")
                
            case "mFighting":
                player1.health += 3
                player2.health -= 1
                print("mFighting")
                print(player1.health)
                print(player2.health)
                print(player1.currStamina)
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
        
        
        
    }
    @IBAction func placeBottomPress(_ sender: Any) {
    }
    @IBAction func endTurnPress(_ sender: Any) {
    }
    @IBAction func shufflePress(_ sender: Any) {
    }
    @IBAction func surrenderPress(_ sender: Any) {
    }
}

