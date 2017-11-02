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
    
    /*func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/
    
}
