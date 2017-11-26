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
    
    //  ***** TEST DEBUFFS *****
    
    //
    // Checks Brass Knuckles debuff under normal circumstances. Debuff should deal one damage when played and 2 damage per turn for two turns to opponent.
    //
    func testBrassKnuckles()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Brass-Knuckles-Deck"]
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Brass Knuckles
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check if Brass Knuckles debuff is applied.
        XCTAssertTrue(player2.debuff == "Brass-Knuckles-Deck")
        
        //Check player 2's health.
        XCTAssertTrue(player2.health == 19)
        
        //Pass turn to player 2 and check player 2's health.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.health == 17)
                
        //Pass one full turn and check player 2's health.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.health == 15)
                    
        //Pass one more full turn
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Chek that debuff is gone.
        XCTAssertTrue(player2.debuff == "")
 
        //Check that player 2's health did not change.
        XCTAssertTrue(player2.health == 15)
    }
    
    //
    // Checks Voodoo Doll debuff under normal circumstances. Debuff should disallow the "placeBottom" function to work for player 2 for 2 turns.
    //
    func testVoodooDoll()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Voodoo-Doll-Deck"]
        //Set a random deck for player 2 to check that placeBottom does not happen
        player2.currDeck = ["Life-Steal-Deck","Mana-Potion-Deck","Voodoo-Doll-Deck", "Disarm-Deck"]
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Voodoo Doll.
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
    
    //
    // Check Bad Medicine debuff interaction with Life Steal. Debuff should negate Life Steal's healing.
    //
    func testBadMedicineWithLifesteal()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Bad-Medicine-Deck"]
        player2.currDeck = ["Life-Steal-Deck"]
        player2.health = 15 //Used to check if health goes up
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Bad Medicine.
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
    
    //
    // Check Bad Medicine debuff interaction with Health Potion. Debuff should negate Health Potion's healing.
    //
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
    
    //
    // Check Disarm debuff interaction with Magical Bolt when only one attack happens per turn. Debuff should reduce Megical Bolt's damage by 2 for the first attack of the turn while the debuff is active.
    //
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
    
    //
    // Check Disarm debuff interaction with Sword Strike when only one attack happens per turn. Debuff should reduce Sword Strike's damage by 2 for the first attack of a turn while the debuff is active.
    //
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
    
    //
    // Check Disarm debuff interaction with Magical Bolt when two attacks happens per turn. Debuff should reduce Magical Bolt's damage by 2 for the first attack of a turn while the debuff is active.
    //
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
    
    //
    //Check Disarm debuff interaction with Sword Strike when two attacks happens per turn. Debuff should reduce Sword Strike's damage by 2 for the first attack of a turn while the debuff is active.
    //
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
    
    //
    //Check Disarm debuff interaction with Arcane Burst. Debuff should reduce Arcane Burst's damage to self by 2 and then deal full damage to opponent.
    //
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
    
    //
    //Check Disarm debuff interaction with Double Edge. Debuff should reduce Double Edge's damage to self by 2 and then deal full damage to opponent.
    //
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
    
    //
    // Check Disarm debuff interaction with Throwing Knife. Debuff should reduce Throwing Knife's damage by 2 thus completely negating its first attack damage while the debuff is active.
    //
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
    }
    
    //
    // Check Disarm debuff interaction with Life Steal. Debuff should reduce Life Steal's damage by 2 thus completely negating its first attack damage while the debuff is active.
    //
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
    
    //
    // Check Disarm debuff interaction with Barbaric Burglary. Debuff should reduce Barbaric Burglary's damage by 2 thus completely negating its first attack damage while the debuff is active.
    //
    func testDisarmWithBarbaricBurglary()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Disarm-Deck"]
        player2.currDeck = ["Barbaric-Burglary-Deck"]
        player1.health = 15 //Used to check that health is not being added
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Disarm-Deck")
        
        //End turn to make it player 2's turn. Player 2 now plays Barbaric Burglary.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check if player 1 receives the correct amount of damage.
        XCTAssertTrue(player1.health == 15)
    }
    
    //
    // Check Disarm's behavior when the player with the debuff chooses to not use attack cards. Disarm should not influence any non-attack card and should become inactive after 2 turns.
    //
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
    
    //
    // Check Disarm's behavior when the player with the debuff chooses to not use attack cards on the first turn and then use an attack card on the second turn.
    //
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
   
    //
    // Checks Sabotage debuff under normal circumstances. Debuff should deal one damage when played and remove 2 of stamina from opponent's current stamina for 2 turns.
    //
    func testSabotage()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Sabotage-Deck"]
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        XCTAssertTrue(player2.hasSabotage == false)
        
        //Player 1 plays Sabotage debuff.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Sabotage-Deck")
        XCTAssertTrue(player2.hasSabotage == true)
        
        //Check player 2's health.
        XCTAssertTrue(player2.health == 19)
        
        //Pass the turn to Player 2. Check Player 2's stamina.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.hasSabotage == true)
        XCTAssertTrue(player2.currStamina == 0) //2 - 2 = 0
        
        //Pass one full turn and check Player 2's stamina.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.hasSabotage == true)
        XCTAssertTrue(player2.currStamina == 2)
        XCTAssertTrue(player2.debuff == "Sabotage-Deck")
        
        //Pass one more full turn
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff is gone
        XCTAssertTrue(player2.debuff == "")
        XCTAssertTrue(player2.hasSabotage == false)
        
        //Check that Player 2's stamina is back to normal.
        XCTAssertTrue(player2.currStamina == 6)

        //One more check is done due to the way stamina is added back.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check player 2's stamina one final time.
        XCTAssertTrue(player2.currStamina == 8)
    }
    
    //
    // Checks Sabotage debuff when opponent has 10 stamina. Debuff should deal one damage when played and remove 2 of stamina from opponent's current stamina for 2 turns.
    //
    func testSabotageWith10Stamina()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Sabotage-Deck"]
        player2.currStamina = 10
        player2.totalStamina = 10
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Sabotage debuff.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff was added succesfully
        XCTAssertTrue(player2.debuff == "Sabotage-Deck")
        
        //Pass the turn to Player 2. Check Player 2's stamina.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.hasSabotage == true)
        XCTAssertTrue(player2.currStamina == 8)
        print("\n\n\n \(player2.currStamina) \n\n\n")
        
        //Pass one full turn and check Player 2's stamina.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.currStamina == 8)
        XCTAssertTrue(player2.debuff == "Sabotage-Deck")
        
        //Pass one more full turn
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check that debuff is gone
        XCTAssertTrue(player2.debuff == "")
        
        //Check that Player 2's stamina is back to normal.
        XCTAssertTrue(player2.currStamina == 10)
    }
    // ***** END OF DEBUFFS *****
    
    // ***** TEST ATTACK CARDS *****
    
    //
    // Check Magical Bolt attack card both with 0 attack and with x attack. Magical bolt should deal a base of 2 damage plus the player's attack stat to the opponent.
    //
    func testMagicalBolt()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Magical-Bolt-Deck"]
        player2.currDeck = ["Magical-Bolt-Deck"]
        player2.attack = 3 //To check Magical Bolt with and without extra attack in the same test
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 attacks player 2 with Magical Bolt and 0 extra attack.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check Player 2's Health.
        XCTAssertTrue(player2.health == 18)
        
        //Check Player 1's Attack.
        XCTAssertTrue(player1.attack == 0)
        
        //Pass the turn and player 2 attacks player 1 with Magical Bolt and 1 extra attack.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check Player 1's Health.
        XCTAssertTrue(player1.health == 15)
        
        //Check Player 2's Attack.
        XCTAssertTrue(player2.attack == 3)
        
    }
    
    //
    // Check Sword Strike attack card both with 0 attack and with x attack. Sword Strike should deal a base of 2 damage plus the player's attack stat to the opponent.
    //
    func testSwordStrike()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Sword-Strike-Deck"]
        player2.currDeck = ["Sword-Strike-Deck"]
        player2.attack = 3 //To check Magical Bolt with and without extra attack in the same test
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 attacks player 2 with Magical Bolt and 0 extra attack.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check Player 2's Health.
        XCTAssertTrue(player2.health == 18)
        
        //Check Player 1's Attack.
        XCTAssertTrue(player1.attack == 0)
        
        //Pass the turn and player 2 attacks player 1 with Magical Bolt and 3 extra attack.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check Player 1's Health.
        XCTAssertTrue(player1.health == 15)
        
        //Check Player 2's Attack.
        XCTAssertTrue(player2.attack == 3)
    }
    
    //
    // Check Arcane Burst attack card both with 0 attack and with x attack. Arcane Burst should reduce player 1's health by player 1's current attack stat and reduce player 2's health by player 1's attack stat times 2 plus 2 (atk*2+2)
    //
    func testArcaneBurst()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Arcane-Burst-Deck"]
        player2.currDeck = ["Arcane-Burst-Deck"]
        player2.attack = 3 //To check Arcane Burst with and without extra attack in the same test
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 attacks player 2 with Arcane Burst and 0 extra attack.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check Player 1's Health
        XCTAssertTrue(player1.health == 20)
        
        //Check Player 2's Health.
        XCTAssertTrue(player2.health == 18)
        
        //Check Player 1's Attack.
        XCTAssertTrue(player1.attack == 0)
        
        //Pass the turn and player 2 attacks player 1 with Arcane Burst and 3 extra attack.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check Player 2's Health
        XCTAssertTrue(player2.health == 15)
        
        //Check Player 1's Health.
        XCTAssertTrue(player1.health == 12)
        
        //Check Player 2's Attack.
        XCTAssertTrue(player2.attack == 3)
    }
    
    //
    // Check Double Edge attack card both with 0 attack and with x attack. Double Edge should reduce player 1's health by player 1's current attack stat and reduce player 2's health by player 1's attack stat times 2 plus 2 (atk*2+2)
    //
    func testDoubleEdge()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Double-Edge-Deck"]
        player2.currDeck = ["Double-Edge-Deck"]
        player2.attack = 3 //To check Arcane Burst with and without extra attack in the same test
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 attacks player 2 with Arcane Burst and 0 extra attack.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check Player 1's Health
        XCTAssertTrue(player1.health == 20)
        
        //Check Player 2's Health.
        XCTAssertTrue(player2.health == 18)
        
        //Check Player 1's Attack.
        XCTAssertTrue(player1.attack == 0)
        
        //Pass the turn and player 2 attacks player 1 with Arcane Burst and 3 extra attack.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check Player 2's Health
        XCTAssertTrue(player2.health == 15)
        
        //Check Player 1's Health.
        XCTAssertTrue(player1.health == 12)
        
        //Check Player 2's Attack.
        XCTAssertTrue(player2.attack == 3)
    }
    
    //
    // Check Throwing Knife attack card under normal circumstances. Throwing Knife should reduce opponent's health by 1 and give player 1 2 stamina back.
    //
    func testThrowingKnife()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Throwing-Knife-Deck"]
        player2.currDeck = ["Throwing-Knife-Deck"]
        player1.attack = 3
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 attacks player 2 with throwing knife. Extra attack should not matter.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check Player 2's Health
        XCTAssertTrue(player2.health == 19)
        
        //Check Player 1's Attack
        XCTAssertTrue(player1.attack == 3)
        
        //Check Player 1's Currens Stamina
        XCTAssertTrue(player1.currStamina == 2)
        
        //Check Player 1's Total Stamina
        XCTAssertTrue(player1.totalStamina == 2)
    }
    
    //
    // Check Life Steal attack card under normal circumstances. Life Steal should
    //
    func testLifeSteal()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Life-Steal-Deck"]
        player2.currDeck = ["Life-Steal-Deck"]
        player1.attack = 3
        player1.health = 15
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 attacks player 2 with Life Steal. Extra attack should not matter.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check Player 1's Health
        XCTAssertTrue(player1.health == 18)
        
        //Check Player 2's Health
        XCTAssertTrue(player2.health == 19)
        
        //Check Player 1's Attack
        XCTAssertTrue(player1.attack == 3)
        
        //Pass the turn to player 2 and play Life Steal
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check Player 1's Health
        XCTAssertTrue(player1.health == 17)
        
        //Check Player 2's Health
        XCTAssertTrue(player2.health == 20)
    }
    
    // ***** END OF ATTACK CARDS *****
    
    // ***** START OF EXTRA CARDS *****
    
    func testSmokeBomb()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Smoke-Bomb-Deck"]
        player2.currDeck = ["Life-Steal-Deck", "Mana-Potion-Deck", "Smoke-Bomb-Deck"]
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Smoke Bomb. Player 2's deck is modified appropriately.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that player 2's deck has been modified.
        XCTAssertTrue(player2.currDeck == ["Mana-Potion-Deck", "Smoke-Bomb-Deck", "Life-Steal-Deck"])
        
        //Pass the turn and check that player 2's deck hasn't been modified.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.currDeck == ["Mana-Potion-Deck", "Smoke-Bomb-Deck", "Life-Steal-Deck"])
    }
    
    func testGoblinGreed()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Goblin-Greed-Deck"]
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Goblin Greed.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that player 1's stamina has been updated.
        XCTAssertTrue(player1.currStamina == 4)
        
        //Pass a turn and check player 1's stamina.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player1.currStamina == 2)
        
        //Pass another turn and check that player 1's stamina is back to normal.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player1.currStamina == 6)
    }
    
    func testGoblinGreedWith10Stamina()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Goblin-Greed-Deck"]
        player1.currStamina = 10
        player1.totalStamina = 10
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Goblin Greed.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that player 1's stamina is still 10.
        XCTAssertTrue(player1.currStamina == 10)
        
        //Pass a full turn and check player 1's stamina.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player1.currStamina == 8)
    }
    
    func testBarbaricBurglary()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Barbaric-Burglary-Deck"]
        player2.currDeck = ["Life-Steal-Deck", "Mana-Potion-Deck", "Smoke-Bomb-Deck"]
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Smoke Bomb.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 2's health.
        XCTAssertTrue(player2.health == 18)
        
        //Check that player 2's deck has been modified.
        XCTAssertTrue(player2.currDeck == ["Mana-Potion-Deck", "Smoke-Bomb-Deck", "Life-Steal-Deck"])
        
        //Pass the turn and check that player 2's deck hasn't been modified.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.currDeck == ["Mana-Potion-Deck", "Smoke-Bomb-Deck", "Life-Steal-Deck"])
    }
    
    func testTheft()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Theft-Deck", "a", "b", "c", "d"]
        player2.currDeck = ["v" ,"w", "x", "y", "z"]
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Theft.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's stamina.
        XCTAssertTrue(player1.currStamina == 2)
        
        //Check player 1's deck.
        XCTAssertTrue(player1.currDeck == ["v", "a", "b", "c", "d"])
        
        //Check player 2's deck.
        XCTAssertTrue(player2.currDeck == ["w","x","y", "z", "Theft-Deck"])
    }
    
    //
    // Check Double Edge attack card both with 0 attack and with x attack. Double Edge should reduce player 1's health by player 1's current attack stat and reduce player 2's health by player 1's attack stat times 2 plus 2 (atk*2+2)
    //
    func testVillagePillageWithLowStamina()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Village-Pillage-Deck"]
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Village Pillage.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's current stamina. Should be -2 +5.
        XCTAssertTrue(player1.currStamina == 5)
        
        //Check player 1's health. Should be 5 less.
        XCTAssertTrue(player1.health == 15)
    }
    
    func testVillagePillageWithMaxStaminaAndLowOpponentStamina()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Village-Pillage-Deck"]
        player1.currStamina = 10
        player1.totalStamina = 10
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Village Pillage.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's stamina. Should be current -2.
        XCTAssertTrue(player1.currStamina == 8)
        
        //Check player 2's current stamina. Should be 0.
        XCTAssertTrue(player2.currStamina == 0)
        
        //Pass the turn to player 2 and check that current stamina is still 0.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.currStamina == 0)
        
        //Pass turn to player 1. Check player 2's stamina is back to normal.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player2.currStamina == 4)
    }
    
    
    func testVillagePillageWithMaxStaminaAndHighOpponentStamina()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Village-Pillage-Deck"]
        player1.currStamina = 10
        player1.totalStamina = 10
        player2.currStamina = 10
        player2.totalStamina = 10
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Village Pillage.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's stamina. Should be current -2.
        XCTAssertTrue(player1.currStamina == 8)
        
        //Check player 2's current stamina. Should be 10 - 6 = 4.
        XCTAssertTrue(player2.currStamina == 4)
        
        //Pass the turn to player 2 and check that current stamina is still 4.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player2.currStamina == 4)
        
        //Pass turn to player 1. Check player 2's stamina is back to normal.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player2.currStamina == 10)
    }
    
    
    func testVillagePillageWithGoblinGreed()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Goblin-Greed-Deck", "Village-Pillage-Deck"]
        player1.currStamina = 8
        player1.totalStamina = 8
        player2.currStamina = 8
        player2.totalStamina = 8
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Goblin Greed.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's current stamina. Should be 10.
        XCTAssertTrue(player1.currStamina == 10)
        
        //Player 1 now plays Village-Pillage.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 2's stamina.
        XCTAssertTrue(player2.currStamina == 2)
    }
    // ***** END OF EXTRA CARDS *****
    
    // ***** START OF BUFF CARDS *****
    
    func testBuffArray()
    {
        let player1 = viewGame.player1
        
        player1.name = "testPlayer1"
        
        //Add 3 buffs to buff array
        viewGame.addBuff(newBuff: "1", currPlayer: player1)
        viewGame.addBuff(newBuff: "2", currPlayer: player1)
        viewGame.addBuff(newBuff: "3", currPlayer: player1)
        
        //Check that buffs were added in the expected order.
        XCTAssertTrue(player1.buffArr == ["1", "2", "3"])
        
        //Add one more buff and check if buff array behaves in expected order.
        viewGame.addBuff(newBuff: "4", currPlayer: player1)
        XCTAssertTrue(player1.buffArr == ["2", "3", "4"])
        
        //Add one more buff and check if buff array behaves in expected order.
        viewGame.addBuff(newBuff: "5", currPlayer: player1)
        XCTAssertTrue(player1.buffArr == ["3", "4", "5"])
    }
    
    //Tests liquid courage card and makes sure that buffs stop working once they leave the buff array
    func testLiquidCourage()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Liquid-Courage-Deck"]
        player2.currDeck = ["Liquid-Courage-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"] //3 health potions are used as random buffs to test that buff is gone once it is removed from buff array
        player1.attack = 3
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Liquid Courage.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check if buff was correctly added to buffs array
        XCTAssertTrue(player1.buffArr == ["Liquid-Courage-Deck"])
        
        //Check that attack is not changed yet.
        XCTAssertTrue(player1.attack == 3)
        
        //Pass the turn to player 2. Player 2 plays Liquid Courage
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack after 1 turn.
        XCTAssertTrue(player1.attack == 4)
        
        //Player 1 plays another Liquid Courage buff.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's buff array.
        XCTAssertTrue(player1.buffArr == ["Liquid-Courage-Deck", "Liquid-Courage-Deck"])
        
        //Pass the turn to player 2. Player 2 plays two Health Potions.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Liquid-Courage-Deck", "Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Check player 2's attack stat.
        XCTAssertTrue(player2.attack == 1)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack.
        XCTAssertTrue(player1.attack == 6)
        
        //Pass the turn to player 2.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check player 2's attack.
        XCTAssertTrue(player2.attack == 2)
        
        //Player 2 playes one more Health Potion.
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Pass one full turn.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check that player 2's attack did not change
        XCTAssertTrue(player2.attack == 2)
    }
    
    func testManaPotion()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Mana-Potion-Deck"]
        player2.currDeck = ["Mana-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"] //3 health potions are used as random buffs to test that buff is gone once it is removed from buff array
        player1.attack = 3
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Mana Potion.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check if buff was correctly added to buffs array
        XCTAssertTrue(player1.buffArr == ["Mana-Potion-Deck"])
        
        //Check that attack is not changed yet.
        XCTAssertTrue(player1.attack == 3)
        
        //Pass the turn to player 2. Player 2 plays Mana Potion
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack after 1 turn.
        XCTAssertTrue(player1.attack == 4)
        
        //Player 1 plays another Mana Potion buff.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's buff array.
        XCTAssertTrue(player1.buffArr == ["Mana-Potion-Deck", "Mana-Potion-Deck"])
        
        //Pass the turn to player 2. Player 2 plays two Health Potions.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Mana-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Check player 2's attack stat.
        XCTAssertTrue(player2.attack == 1)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack.
        XCTAssertTrue(player1.attack == 6)
        
        //Pass the turn to player 2.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check player 2's attack.
        XCTAssertTrue(player2.attack == 2)
        
        //Player 2 playes one more Health Potion.
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Pass one full turn.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check that player 2's attack did not change
        XCTAssertTrue(player2.attack == 2)
    }
    
    func testCoinCraze()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Coin-Craze-Deck"]
        player2.currDeck = ["Coin-Craze-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"] //3 health potions are used as random buffs to test that buff is gone once it is removed from buff array
        player1.attack = 3
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Coin Craze.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check if buff was correctly added to buffs array
        XCTAssertTrue(player1.buffArr == ["Coin-Craze-Deck"])
        
        //Check that attack is not changed yet.
        XCTAssertTrue(player1.attack == 3)
        
        //Pass the turn to player 2. Player 2 plays Coin Craze
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack after 1 turn.
        XCTAssertTrue(player1.attack == 4)
        
        //Player 1 plays another Coin Craze buff.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's buff array.
        XCTAssertTrue(player1.buffArr == ["Coin-Craze-Deck", "Coin-Craze-Deck"])
        
        //Pass the turn to player 2. Player 2 plays two Health Potions.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Coin-Craze-Deck", "Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Check player 2's attack stat.
        XCTAssertTrue(player2.attack == 1)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack.
        XCTAssertTrue(player1.attack == 6)
        
        //Pass the turn to player 2.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check player 2's attack.
        XCTAssertTrue(player2.attack == 2)
        
        //Player 2 playes one more Health Potion.
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Pass one full turn.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check that player 2's attack did not change
        XCTAssertTrue(player2.attack == 2)
    }
    
    //Test LiquidCourage with more than 10 attack
    
    //NOTE: ASK IF BUFF SHOULD BE EXECUTED IMMEDIATELY OR UNTIL NEXT TURN
    func testBlackSmith()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Blacksmith-Deck"]
        player2.currDeck = ["Blacksmith-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"] //3 health potions are used as random buffs to test that buff is gone once it is removed from buff array
        player1.attack = 3
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays BlackSmith.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check if buff was correctly added to buffs array
        XCTAssertTrue(player1.buffArr == ["Blacksmith-Deck"])
        
        //Check that attack has changed.
        XCTAssertTrue(player1.attack == 6)
        
        //Pass the turn to player 2. Player 2 plays BlackSmith
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack after 1 turn.
        XCTAssertTrue(player1.attack == 6)
        
        //Player 1 plays another BlackSmith buff.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's buff array.
        XCTAssertTrue(player1.buffArr == ["Blacksmith-Deck", "Blacksmith-Deck"])
        
        //Pass the turn to player 2. Player 2 plays two Health Potions.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Blacksmith-Deck", "Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Check player 2's attack stat.
        XCTAssertTrue(player2.attack == 3)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack.
        XCTAssertTrue(player1.attack == 9)
        
        //Pass the turn to player 2.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check player 2's attack.
        XCTAssertTrue(player2.attack == 3)
        
        //Player 2 playes one more Health Potion.
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Check that buff has been removed.
        XCTAssertTrue(player2.attack == 0)
        
        //Pass one full turn.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check that player 2's attack did not change
        XCTAssertTrue(player2.attack == 0)

    }
    
    func testBlackSmithWithOverTenAttack()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Blacksmith-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"]
        player1.attack = 9
        player1.currStamina = 10
        player1.totalStamina = 10
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays BlackSmith.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Pass one full turn.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's attack.
        XCTAssertTrue(player1.attack == 12)
        
        //Add three Health Potion buffs
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that buff has been removed
        XCTAssertTrue(player1.attack == 9)
    }
    
    func testSpellTome()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Spell-Tome-Deck"]
        player2.currDeck = ["Spell-Tome-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"] //3 health potions are used as random buffs to test that buff is gone once it is removed from buff array
        player1.attack = 3
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Spell Tome.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check if buff was correctly added to buffs array
        XCTAssertTrue(player1.buffArr == ["Spell-Tome-Deck"])
        
        //Check that attack has changed.
        XCTAssertTrue(player1.attack == 6)
        
        //Pass the turn to player 2. Player 2 plays Spell Tome
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack after 1 turn.
        XCTAssertTrue(player1.attack == 6)
        
        //Player 1 plays another Spell Tome buff.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's buff array.
        XCTAssertTrue(player1.buffArr == ["Spell-Tome-Deck", "Spell-Tome-Deck"])
        
        //Pass the turn to player 2. Player 2 plays two Health Potions.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Spell-Tome-Deck", "Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Check player 2's attack stat.
        XCTAssertTrue(player2.attack == 3)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack.
        XCTAssertTrue(player1.attack == 9)
        
        //Pass the turn to player 2.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check player 2's attack.
        XCTAssertTrue(player2.attack == 3)
        
        //Player 2 playes one more Health Potion.
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Check that buff has been removed.
        XCTAssertTrue(player2.attack == 0)
        
        //Pass one full turn.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check that player 2's attack did not change
        XCTAssertTrue(player2.attack == 0)
    }
    
    func testSpellTomeWithOverTenAttack()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Spell-Tome-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"]
        player1.attack = 9
        player1.currStamina = 10
        player1.totalStamina = 10
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Spell Tome.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Pass one full turn.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's attack.
        XCTAssertTrue(player1.attack == 12)
        
        //Add three Health Potion buffs
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that buff has been removed
        XCTAssertTrue(player1.attack == 9)
    }
    
    func testCallTheHorde()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Call-The-Horde-Deck"]
        player2.currDeck = ["Call-The-Horde-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"] //3 health potions are used as random buffs to test that buff is gone once it is removed from buff array
        player1.attack = 3
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Spell Tome.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check if buff was correctly added to buffs array
        XCTAssertTrue(player1.buffArr == ["Call-The-Horde-Deck"])
        
        //Check that attack has changed.
        XCTAssertTrue(player1.attack == 6)
        
        //Pass the turn to player 2. Player 2 plays Spell Tome
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack after 1 turn.
        XCTAssertTrue(player1.attack == 6)
        
        //Player 1 plays another Spell Tome buff.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's buff array.
        XCTAssertTrue(player1.buffArr == ["Call-The-Horde-Deck", "Call-The-Horde-Deck"])
        
        //Pass the turn to player 2. Player 2 plays two Health Potions.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Call-The-Horde-Deck", "Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Check player 2's attack stat.
        XCTAssertTrue(player2.attack == 3)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack.
        XCTAssertTrue(player1.attack == 9)
        
        //Pass the turn to player 2.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check player 2's attack.
        XCTAssertTrue(player2.attack == 3)
        
        //Player 2 playes one more Health Potion.
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Check that buff has been removed.
        XCTAssertTrue(player2.attack == 0)
        
        //Pass one full turn.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check that player 2's attack did not change
        XCTAssertTrue(player2.attack == 0)
    }
    
    func testCallTheHordeWithOverTenAttack()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Call-The-Horde-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"]
        player1.attack = 9
        player1.currStamina = 10
        player1.totalStamina = 10
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Spell Tome.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Pass one full turn.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's attack.
        XCTAssertTrue(player1.attack == 12)
        
        //Add three Health Potion buffs
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check that buff has been removed
        XCTAssertTrue(player1.attack == 9)
    }
    
    func testHealthPotion()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Health-Potion-Deck"]
        player1.health = 10
        player2.health = 10
        player2.currDeck = ["Health-Potion-Deck", "Spell-Tome-Deck", "Spell-Tome-Deck", "Spell-Tome-Deck"]
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Health Potion
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check if buff was correctly added to buffs array
        XCTAssertTrue(player1.buffArr == ["Health-Potion-Deck"])
        
        //Check that health hasn't changed yet
        XCTAssertTrue(player1.health == 10)
        
        //Pass the turn to player 2. Player 2 plays Health Potion
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's health after 1 turn.
        XCTAssertTrue(player1.health == 12)
        
        //Player 1 plays another Health Potion buff.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's buff array.
        XCTAssertTrue(player1.buffArr == ["Health-Potion-Deck", "Health-Potion-Deck"])
        
        //Pass the turn to player 2. Player 2 plays two Spell Tomes.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Health-Potion-Deck", "Spell-Tome-Deck", "Spell-Tome-Deck"])
        
        //Check player 2's health stat.
        XCTAssertTrue(player2.health == 12)
        
        //Pass the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's health.
        XCTAssertTrue(player1.health == 16)
        
        //Pass the turn to player 2.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check player 2's health.
        XCTAssertTrue(player2.health == 14)
        
        //Player 2 playes one more Spell Tome.
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's buff array.
        XCTAssertTrue(player2.buffArr == ["Spell-Tome-Deck", "Spell-Tome-Deck", "Spell-Tome-Deck"])
        
        //Pass one full turn.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Check that player 2's health did not change
        XCTAssertTrue(player2.health == 14)
    }
    
    // ***** END OF BUFF CARDS *****
    
    // ***** START OF CAP TESTS
    
    func testAttackCap()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Magical-Bolt-Deck"]
        player2.currDeck = ["Liquid-Courage-Deck", "Spell-Tome-Deck", "Liquid-Courage-Deck", "Magical-Bolt-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Health-Potion-Deck"]
        player1.attack = 12
        player2.attack = 8
        player2.currStamina = 10
        player2.totalStamina = 10
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 passes the turn to player 2. Player 2 plays Liquid Courage.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Player 2 passes the turn to player 1.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        
        //Check player 1's attack. Note that attack will only go back to 10 before an attack card is played.
        XCTAssertTrue(player1.attack == 12)
        
        //Player 1 plays magical bolt.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's attack. Attack should have gone back to 10.
        XCTAssertTrue(player1.attack == 10)
        
        //Check that only 10 damage was done to player 2.
        XCTAssertTrue(player2.health == 10)
        
        //Player 1 passes the turn. Player 2 plays Spell Tome, another Liquid Courage, and Magical Bolt.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check player 2's attack:
        XCTAssertTrue(player2.attack == 12)
        print ("\n\n\n \(player2.attack) \n\n\n")
        
        //Check player 1's health:
        XCTAssertTrue(player1.health == 10)
        
        //Pass one full turn. It is now player 2's turn again.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        
        //Player 2 plays 3 health potions.
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        viewGame.playCard(currPlayer: player2, nextPlayer: player1)
        
        //Check Player 2's attack
        XCTAssertTrue(player2.attack == 11) //11 Because it gains 2 from liquid courage -> 14 and loses 3 from losing Spell Tome.
        print ("\n\n\n \(player2.attack) \n\n\n")
    }
    
    //Check that neither Health Potion nor Lifesteal can put health at more than 20.
    func testHPCap()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Health-Potion-Deck", "Life-Steal-Deck"]
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Player 1 plays Health Potion.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Pass a full turn and check player 1's health.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player1.health == 20)
        
        //Player 1 plays lifesteal.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's health.
        XCTAssertTrue(player1.health == 20)
    }
    
    func testStaminaCap()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Throwing-Knife-Deck"]
        player1.currStamina = 13
        player1.totalStamina = 10
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Pass a full turn and check player 1's stamina.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player1.currStamina == 10)
        XCTAssertTrue(player1.totalStamina == 10)
        
        //Player 1 plays throwing knife with 10 stamina.
        viewGame.playCard(currPlayer: player1, nextPlayer: player2)
        
        //Check player 1's stamina.
        XCTAssertTrue(player1.currStamina == 10)
        XCTAssertTrue(player1.totalStamina == 10)
    }
    
    // ***** END OF CAP TESTS
    
    func testStamina()
    {
        let player1 = viewGame.player1
        let player2 = viewGame.player2
        
        player1.currDeck = ["Throwing-Knife-Deck"]
        player1.name = "testPlayer1"
        player2.name = "testPlayer2"
        
        //Check both player's stamina.
        XCTAssertTrue(player1.currStamina == 2)
        XCTAssertTrue(player1.totalStamina == 2)
        XCTAssertTrue(player2.currStamina == 2)
        XCTAssertTrue(player2.totalStamina == 2)
        
        //Pass a turn to player 2. Check both player's stamina.
        viewGame.endTurn(currPlayer: player1, nextPlayer: player2)
        XCTAssertTrue(player1.currStamina == 4)
        XCTAssertTrue(player1.totalStamina == 4)
        XCTAssertTrue(player2.currStamina == 2)
        XCTAssertTrue(player2.totalStamina == 2)
        
        //Pass a turn to player 1. Check both player's stamina.
        viewGame.endTurn(currPlayer: player2, nextPlayer: player1)
        XCTAssertTrue(player1.currStamina == 4)
        XCTAssertTrue(player1.totalStamina == 4)
        XCTAssertTrue(player2.currStamina == 4)
        XCTAssertTrue(player2.totalStamina == 4)
    }
    
    /*func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/
    
}
