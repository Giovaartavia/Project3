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
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
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
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
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
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
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
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
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
    
    func testDisarmWithMagicalBoltOneAttackPerTurn()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Disarm-Deck"]
        player2.currDeck = ["Magical-Bolt-Deck"]
        player2.attack = 3 //Used to check if damage is being mitigated
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //End turn to make it player 2's turn. Player 2 now plays Magical Bolt.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 17)
        
        //Pass one full turn and make player 2 attack again
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check debuff is still active.
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 14)
        
        //Pass one more full turn and make player 2 attack again.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check that debuff is gone.
        XCTAssertTrue(player2.debuff == "")
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 9)
    }
    
    func testDisarmWithSwordStrikeOneAttackPerTurn()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Disarm-Deck"]
        player2.currDeck = ["Sword-Strike-Deck"]
        player2.attack = 3 //Used to check if damage is being mitigated
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //End turn to make it player 2's turn. Player 2 now plays Magical Bolt.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 17)
        
        //Pass one full turn and make player 2 attack again
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check debuff is still active.
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 14)
        
        //Pass one more full turn and make player 2 attack again.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check that debuff is gone.
        XCTAssertTrue(player2.debuff == "")
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 9)
    }
    
    func testDisarmWithMagicalBoltTwoAttacksPerTurn()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Disarm-Deck"]
        player2.currDeck = ["Magical-Bolt-Deck"]
        player2.attack = 2 //Used to check if damage is being mitigated
        player2.totalStamina = 10
        player2.currStamina = 10 //Used to attack several times per turn
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //End turn to make it player 2's turn. Player 2 now plays Magical Bolt.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 18)
        
        //Attack again and check that damage mitigation is no longer taking effect.
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player1.health == 14)
        
        //Pass one full turn and make player 2 attack again
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check debuff is still active.
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 12)
        
        //Attack again and check that damage mitigation is no longer taking effect.
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player1.health == 8)
        
        //Pass one more full turn and make player 2 attack again.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check that debuff is gone.
        XCTAssertTrue(player2.debuff == "")
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 4)
    }
    
    func testDisarmWithSwordStrikeTwoAttacksPerTurn()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Disarm-Deck"]
        player2.currDeck = ["Sword-Strike-Deck"]
        player2.attack = 2 //Used to check if damage is being mitigated
        player2.totalStamina = 10
        player2.currStamina = 10 //Used to attack several times per turn
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //End turn to make it player 2's turn. Player 2 now plays Sword Strike.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 18)
        
        //Attack again and check that damage mitigation is no longer taking effect.
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player1.health == 14)
        
        //Pass one full turn and make player 2 attack again
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check debuff is still active.
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 12)
        
        //Attack again and check that damage mitigation is no longer taking effect.
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player1.health == 8)
        
        //Pass one more full turn and make player 2 attack again.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check that debuff is gone.
        XCTAssertTrue(player2.debuff == "")
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 4)
    }
    
    func testDisarmWithArcaneBurst()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Disarm-Deck"]
        player2.currDeck = ["Arcane-Burst-Deck"]
        player2.attack = 3 //Done to check if debuff is mitigating attack
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //End turn to make it player 2's turn. Player 2 now plays Arcane Burst.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check if player 2 receives the correct amount of damage.
        XCTAssertTrue(player2.health == 19)
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 12)
        
    }
    
    func testDisarmWithDoubleEdge()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Disarm-Deck"]
        player2.currDeck = ["Double-Edge-Deck"]
        player2.attack = 3 //Done to check if debuff is mitigating attack
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //End turn to make it player 2's turn. Player 2 now plays Double Edge.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check if player 2 receives the correct amount of damage.
        XCTAssertTrue(player2.health == 19)
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 12)
    }
    
    func testDisarmWithThrowingKnife()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Disarm-Deck"]
        player2.currDeck = ["Throwing-Knife-Deck"]
        player1.health = 15 //Used to check that health is not being added
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //End turn to make it player 2's turn. Player 2 now plays Throwing Knife.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 15)
        print("\n\nPlayer 1's health: \(player1.health)")
    }
    
    func testDisarmWithLifeSteal()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Disarm-Deck"]
        player2.currDeck = ["Life-Steal-Deck"]
        player1.health = 15 //Used to check that health is not being added
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //End turn to make it player 2's turn. Player 2 now plays Throwing Knife.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 15)
    }
    
    func testDisarmWithNoAttacking()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Disarm-Deck"]
        player2.currDeck = ["Sword-Strike-Deck"]
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //Skip two turns and check that neither health nor attack were modified.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.debuff == "")
        XCTAssertTrue(player1.health == 20)
        XCTAssertTrue(player2.attack == 0)
    }
    
    func testDisarmWithNoAttackingFirstTurnAndAttackingSecondTurn()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Disarm-Deck"]
        player2.currDeck = ["Sword-Strike-Deck"]
        player2.attack = 1
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //Skip one turn and attack on second turn.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check that debuff is still active.
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //Skip one more turn.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check that debuff is no longer active
        XCTAssertTrue(player2.debuff == "")
        
        //Check attack and health stats and see if they match with the predicted values.
        XCTAssertTrue(player1.health == 19)
        XCTAssertTrue(player2.attack == 1)
    }
    
    /*func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/
    
}
