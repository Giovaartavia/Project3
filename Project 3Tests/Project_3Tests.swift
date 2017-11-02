//
//  Project_3Tests.swift
//  Project 3Tests
//
//  Created by Giovanni on 10/21/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import XCTest
@testable import Project_3

class Project_3Tests: XCTestCase {
    
    var viewGame = ViewPlayGame()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBrassKnuckles()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Brass-Knuckles-Deck"]
        
        print("\n *****BRASS KNUCKLES TESTS****** \n")
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        XCTAssertTrue(player2.debuff == "Brass-Knuckles-Deck")
        if(player2.debuff == "Brass-Knuckles-Deck")
        {
            print("Correct debuff displayed: Passed!")
        }
        else
        {
            print("Correct debuff displayed: Failed")
        }
        
        XCTAssertTrue(player2.health == 19)
        if(player2.health == 19)
        {
            print("Initial Brass Knuckles damage: Passed!")
            viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
            XCTAssertTrue(player2.health == 17)
            if (player2.health == 17)
            {
                print("First turn Brass Knuckles damage: Passed!")
                
                //Pass one turn
                viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
                viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
                
                XCTAssertTrue(player2.health == 15)
                if(player2.health == 15)
                {
                    print("Second turn Brass Knuckles damage: Passed!")
                    
                    //Pass one turn
                    viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
                    viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
                    
                    XCTAssertTrue(player2.debuff == "")
                    if(player2.debuff == "")
                    {
                        print("Correct debuff displayed after 2 turns: Passed!")
                    }
                    else
                    {
                        print("Correct debuff displayed after 2 turns: Failed")
                    }
                    if(player2.health == 15)
                    {
                        print("Brass Knuckles stops doing damage after 2 turns: Passed!")
                    }
                    else
                    {
                        print("Brass Knuckles stops doing damage after 2 turns: Failed")
                    }
                    
                }
                else
                {
                    print("Second turn Brass Knuckles damage: Failed")
                }
            }
            else
            {
                print("First turn Brass Knuckles damage: Failed")
            }
        }
        else
        {
            print("Initial Brass Knuckles damage: Failed")
        }
        
        print("\n\n\n")
    }
    
    func testVoodooDoll()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Voodoo-Doll-Deck"]
        //Set a random deck for player 2 to check that placeBottom does not happen
        player2.currDeck = ["Life-Steal-Deck","Mana-Potion-Deck","Voodoo-Doll-Deck", "Disarm-Deck"]
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Voodoo-Doll-Deck")
        //Check that 1 damage was dealt as card was played
        XCTAssertTrue(player2.health == 19)
        
        //End turn to make it player 2's turn. Player 2 now tries to addBack
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.placeBottom(currPlayer: player2)
        
        //Check that deck was not changed
        XCTAssertTrue(player2.currDeck == ["Life-Steal-Deck","Mana-Potion-Deck","Voodoo-Doll-Deck", "Disarm-Deck"])
        //Check that no stamina was spent
        XCTAssertTrue(player2.currStamina == 2)
        
        //Pass one full turn and check that debuff is still in place
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.placeBottom(currPlayer: player2)
        
        //Check that deck was not changed
        XCTAssertTrue(player2.currDeck == ["Life-Steal-Deck","Mana-Potion-Deck","Voodoo-Doll-Deck", "Disarm-Deck"])
        
        //Pass one more full turn and check that debuff is gone
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check debuff is gone
        XCTAssertTrue(player2.debuff == "")
        //Check if placeBottom is working
        viewGame.placeBottom(currPlayer: player2)
        XCTAssertTrue(player2.currDeck == ["Mana-Potion-Deck","Voodoo-Doll-Deck", "Disarm-Deck", "Life-Steal-Deck"])
        
    }
    
    func testBadMedicineWithLifesteal()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Bad-Medicine-Deck"]
        player2.currDeck = ["Life-Steal-Deck"]
        player2.health = 15 //Used to check if health goes up
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Bad-Medicine-Deck")
        
        //End turn to make it player 2's turn. Player 2 now plays Lifesteal
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check if Player 2's health was healed
        XCTAssertTrue(player2.health == 15)
        
        //Pass one full turn and check if debuff is still active
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        XCTAssertTrue(player2.debuff == "Bad-Medicine-Deck")
        
        //Pass one more full turn and check that debuff is gone
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        XCTAssertTrue(player2.debuff == "")
        
        //Player 2 uses Lifesteal again and this time it should heal by +3
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player2.health == 18)
    }
    
    func testBadMedicineWithHealthPotion()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Bad-Medicine-Deck"]
        player2.currDeck = ["Health-Potion-Deck"]
        player2.health = 15 //Used to check if health goes up
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Bad-Medicine-Deck")
        
        //End turn to make it player 2's turn. Player 2 now plays Bad Medicine.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Pass one full turn and check if player 2 gained hp from the buff
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.health == 15)
        
        //Pass another full turn and check that player 2 gains 2 hp from buff
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.health == 17)
        
        //Check that debuff is gone
        XCTAssertTrue(player2.debuff == "")
    }
    
    /*func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/
    
}
