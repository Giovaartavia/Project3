//
//  GamePlayingScreen.swift
//  Project 3
//
//  Created by Giovanni, Brandon, Dylan, James on 10/24/17.
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


///Assigned by the coin flip
var playerStart = 0;

/// Class that handles player 1's class/deck selection
class SelectionDeck1: UIViewController {
    var currDeck = ["Initial"];
    override func viewDidLoad() {
        //Nothing yet :)
    }
    @IBOutlet weak var segmentSelect: UISegmentedControl!
    
    let warriorDeck = ["Throwing-Knife-Deck", "Throwing-Knife-Deck","Liquid-Courage-Deck","Liquid-Courage-Deck","Liquid-Courage-Deck","Brass-Knuckles-Deck", "Brass-Knuckles-Deck", "Disarm-Deck", "Disarm-Deck", "Blacksmith-Deck", "Smoke-Bomb-Deck", "Smoke-Bomb-Deck", "Double-Edge-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Bad-Medicine-Deck", "Bad-Medicine-Deck", "Sword-Strike-Deck", "Sword-Strike-Deck", "Sword-Strike-Deck"]
    
    let mageDeck = ["Life-Steal-Deck", "Life-Steal-Deck","Mana-Potion-Deck","Mana-Potion-Deck","Mana-Potion-Deck","Voodoo-Doll-Deck", "Voodoo-Doll-Deck", "Disarm-Deck", "Disarm-Deck", "Spell-Tome-Deck", "Smoke-Bomb-Deck", "Smoke-Bomb-Deck", "Arcane-Burst-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Bad-Medicine-Deck", "Bad-Medicine-Deck", "Magical-Bolt-Deck", "Magical-Bolt-Deck", "Magical-Bolt-Deck"]
    
    ///Function that is called once Player 1 presses the Select Class button to confirm their class.
    ///This sets which deck Player 1 will use.
    /// - Sources:
    ///     - function adapted from https://stackoverflow.com/questions/31587181/sending-array-data-from-one-view-controller-to-another
    /// - Parameters:
    ///   - sender: function called when button is pressed
    @IBAction func confirmSelection(_ sender: Any) {
        switch segmentSelect.selectedSegmentIndex
        {
        case 0:
            let defaults = UserDefaults.standard
            //currDeck = warriorDeck.shuffled()
            currDeck = warriorDeck
            defaults.set(currDeck, forKey: "deck1")
            
        case 1:
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = mageDeck
            defaults.set(currDeck, forKey: "deck1")
        default:
            currDeck = ["ERROR"]
            break
        }
    }
}

/// Class that handles player 2's class/deck selection
class SelectionDeck2: UIViewController {
    var currDeck = ["Initial"];
    override func viewDidLoad() {
        //Nothing yet :)
    }
    @IBOutlet weak var segmentSelect: UISegmentedControl!
    
    let warriorDeck = ["Throwing-Knife-Deck", "Throwing-Knife-Deck","Liquid-Courage-Deck","Liquid-Courage-Deck","Liquid-Courage-Deck","Brass-Knuckles-Deck", "Brass-Knuckles-Deck", "Disarm-Deck", "Disarm-Deck", "Blacksmith-Deck", "Smoke-Bomb-Deck", "Smoke-Bomb-Deck", "Double-Edge-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Bad-Medicine-Deck", "Bad-Medicine-Deck", "Sword-Strike-Deck", "Sword-Strike-Deck", "Sword-Strike-Deck"]
    
    let mageDeck = ["Life-Steal-Deck", "Life-Steal-Deck","Mana-Potion-Deck","Mana-Potion-Deck","Mana-Potion-Deck","Voodoo-Doll-Deck", "Voodoo-Doll-Deck", "Disarm-Deck", "Disarm-Deck", "Spell-Tome-Deck", "Smoke-Bomb-Deck", "Smoke-Bomb-Deck", "Arcane-Burst-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Bad-Medicine-Deck", "Bad-Medicine-Deck", "Magical-Bolt-Deck", "Magical-Bolt-Deck", "Magical-Bolt-Deck"]
    
    ///Function that is called once Player 2 presses the Select Class button to confirm their class.
    ///This sets which deck Player 2 will use.
    /// - Sources:
    ///     - function adapted from https://stackoverflow.com/questions/31587181/sending-array-data-from-one-view-controller-to-another
    /// - Parameters:
    ///   - sender: function called when button is pressed
    @IBAction func confirmSelection(_ sender: Any) {
        switch segmentSelect.selectedSegmentIndex
        {
        case 0:
            let defaults = UserDefaults.standard
            //currDeck = warriorDeck.shuffled()
            currDeck = warriorDeck
            defaults.set(currDeck, forKey: "deck2")
        case 1:
            let defaults = UserDefaults.standard
            //currDeck = mageDeck.shuffled()
            currDeck = mageDeck
            defaults.set(currDeck, forKey: "deck2")
        default:
            currDeck = ["ERROR"]
            break
        }
    }
}

///Class that contains the entire game playing screen.
class ViewPlayGame: UIViewController {
    ///This is the Player 1 Object
    var player1 = Player(name: "player1", currDeck: ["Empty"], deck: "None")
    ///This is the Player 1 Object
    var player2 = Player(name: "player2", currDeck: ["Empty"], deck: "None")
    
    ///This function is called once the View Play Game Screen is loaded
    override func viewDidLoad()
    {
        if(playerStart == 1)
        {
            playerTurn.text = "PLAYER 1's Turn"
            
        }
        else if(playerStart == 2)
        {
            playerTurn.text = "PLAYER 2's Turn"
        }
        else
        {
            print("ERROR PICKING TURN")
        }
        
        let warriorDeck = ["Throwing-Knife-Deck", "Throwing-Knife-Deck","Liquid-Courage-Deck","Liquid-Courage-Deck","Liquid-Courage-Deck","Brass-Knuckles-Deck", "Brass-Knuckles-Deck", "Disarm-Deck", "Disarm-Deck", "Blacksmith-Deck", "Smoke-Bomb-Deck", "Smoke-Bomb-Deck", "Double-Edge-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Bad-Medicine-Deck", "Bad-Medicine-Deck", "Sword-Strike-Deck", "Sword-Strike-Deck", "Sword-Strike-Deck"]
        
        let mageDeck = ["Life-Steal-Deck", "Life-Steal-Deck","Mana-Potion-Deck","Mana-Potion-Deck","Mana-Potion-Deck","Voodoo-Doll-Deck", "Voodoo-Doll-Deck", "Disarm-Deck", "Disarm-Deck", "Spell-Tome-Deck", "Smoke-Bomb-Deck", "Smoke-Bomb-Deck", "Arcane-Burst-Deck", "Health-Potion-Deck", "Health-Potion-Deck", "Bad-Medicine-Deck", "Bad-Medicine-Deck", "Magical-Bolt-Deck", "Magical-Bolt-Deck", "Magical-Bolt-Deck"]
        
        if let test : AnyObject = UserDefaults.standard.object(forKey: "deck1") as AnyObject {
            let selectedDeck : [NSString] = test as! [NSString]
            player1.currDeck = selectedDeck as [String]
        }
        if let test : AnyObject = UserDefaults.standard.object(forKey: "deck2") as AnyObject {
            let selectedDeck : [NSString] = test as! [NSString]
            player2.currDeck = selectedDeck as [String]
        }
        if(player1.currDeck == warriorDeck)
        {
            player1.deck = "Warrior"
            player1Class.image = UIImage(named: "Warrior-Icon")
        }
        else
        {
            player1.deck = "Mage"
            player1Class.image = UIImage(named: "Mage-Icon")
        }
        if(player2.currDeck == warriorDeck)
        {
            player2.deck = "Warrior"
            player2Class.image = UIImage(named: "Warrior-Icon")
        }
        else
        {
            player2.deck = "Mage"
            player2Class.image = UIImage(named: "Mage-Icon")
        }
        player1.currDeck = player1.currDeck.shuffled()
        player2.currDeck = player2.currDeck.shuffled()
        
        revealTopCard(currPlayer: player1)
        revealTopCard(currPlayer: player2)
        updateStaminaBar(currPlayer: player1)
        updateStaminaBar(currPlayer: player2)
        let holdDeck1 = UILongPressGestureRecognizer(target: self, action: #selector(holdTopCard1(_:)))
        topCard1Button.addGestureRecognizer(holdDeck1)
        let holdDeck2 = UILongPressGestureRecognizer(target: self, action: #selector(holdTopCard2(_:)))
        topCard2Button.addGestureRecognizer(holdDeck2)
        blurTopCard.isHidden = true;
    }
    
    /// Player Object
    /// Object includes a deckArray along with various stats used for gameplay
    ///
    /// - Parameters:
    ///   - name: Player's name. For now just "player1" or "player2"
    ///   - currDeck: Stores which deck the player is using
    ///   - deck: Stores the name of the player's deck "Warrior" or "Mage"
    class Player
    {
        var name: String
        var currDeck: [String]
        var deck: String
        init(name: String, currDeck: [String], deck: String) {
            self.name = name
            self.currDeck = currDeck
            self.deck = deck
        }
        
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
    
    ///Adds first element from array to back of array
    ///
    /// - Parameters:
    ///   - arr: Player's deck that is moving a card to the back of the deck
    func addToBack(arr: inout [String]){
        let tempFirstElement = arr[0]
        arr.remove(at: 0)
        arr.append(tempFirstElement)
    }
    
    
    /// Plays card at the front of currPlayer's array of cards
    /// Modifies both players stats depending on card type played
    ///
    /// - Parameters:
    ///   - currPlayer: Player Object who is executing their turn
    ///   - nextPlayer: Player Object who is not executing their turn
    func playCard(currPlayer: Player, nextPlayer: Player)
    {
        //check stamina
        if(currPlayer.currStamina >= 2)
        {
            //decrease stamina
            currPlayer.currStamina -= 2
            updateStaminaBar(currPlayer: currPlayer)
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
            case "Mana-Potion-Deck", "Liquid-Courage-Deck":
                addBuff(newBuff: currCard, currPlayer: currPlayer)
            //+3 attack once while active
            case "Spell-Tome-Deck", "Blacksmith-Deck":
                currPlayer.attack += 3
                updateAttackBar(currPlayer: currPlayer)
                addBuff(newBuff: currCard, currPlayer: currPlayer)
            //+2 health per turn
            case "Health-Potion-Deck":
                addBuff(newBuff: currCard, currPlayer: currPlayer)
                
                //debuff (LASTS 2 TURNS)
            //subtract 2 ATK from opponent for 1st attack each turn
            case "Disarm-Deck":
                nextPlayer.debuff = "Disarm-Deck"
                updateDebuffBar(currPlayer: nextPlayer)
                nextPlayer.debuffTime = 2 
            //Stops Opponent from healing
            case "Bad-Medicine-Deck":
                nextPlayer.debuff = "Bad-Medicine-Deck"
                updateDebuffBar(currPlayer: nextPlayer)
                nextPlayer.debuffTime = 3      
            //1 damage to opponent
                //mage: Opponent cannot use move card option
            case "Voodoo-Doll-Deck":
                nextPlayer.debuff = "Voodoo-Doll-Deck"
                updateDebuffBar(currPlayer: nextPlayer)
                nextPlayer.debuffTime = 3
                nextPlayer.health -= 1
                updateHealthBar(currPlayer: nextPlayer)
                //warrior: Opponent takes 2 damage per turn
            case "Brass-Knuckles-Deck":
                nextPlayer.debuff = "Brass-Knuckles-Deck"
                updateDebuffBar(currPlayer: nextPlayer)
                nextPlayer.debuffTime = 2
                nextPlayer.health -= 1
                updateHealthBar(currPlayer: nextPlayer)
                
                // single turn
            //Places top card of opponents deck on the bottom
            case "Smoke-Bomb-Deck":
                addToBack(arr: &nextPlayer.currDeck)
                animateDiscard(currPlayer: nextPlayer)
                //revealTopCard(currPlayer: nextPlayer)
            //Does your own atk stat damage to yourself, then (atk * 2) + 2 to opponent.
            case "Arcane-Burst-Deck", "Double-Edge-Deck":
                attackDamage(currPlayer: currPlayer, nextPlayer: currPlayer, damage: currPlayer.attack)
                checkHealth(currPlayer: currPlayer)
                updateHealthBar(currPlayer: currPlayer)
                attackDamage(currPlayer: currPlayer, nextPlayer: nextPlayer, damage: (currPlayer.attack * 2) + 2)
                selfDamage = true
                checkHealth(currPlayer: nextPlayer)
                updateHealthBar(currPlayer: nextPlayer)
            //Does atk + 2 to opponent.
            case "Magical-Bolt-Deck", "Sword-Strike-Deck":
                attackDamage(currPlayer: currPlayer, nextPlayer: nextPlayer, damage: currPlayer.attack + 2)
                updateHealthBar(currPlayer: nextPlayer)
            //Do 1 damage, regain 3 hp.
            case "Life-Steal-Deck":
                checkDebuff(currPlayer: currPlayer, nextPlayer: nextPlayer)
                if(currPlayer.canHeal)
                {
                    currPlayer.health += 3
                    updateHealthBar(currPlayer: currPlayer)
                }
                attackDamage(currPlayer: currPlayer, nextPlayer: nextPlayer, damage: 1)
                updateHealthBar(currPlayer: nextPlayer)
            //Do 1 damage, regain 2 stamina.
            case "Throwing-Knife-Deck":
                currPlayer.currStamina += 2
                updateStaminaBar(currPlayer: currPlayer)
                attackDamage(currPlayer: currPlayer, nextPlayer: nextPlayer, damage: 1)
                updateHealthBar(currPlayer: nextPlayer)
                
            default: //Necessary
                print("Error in card selection switch case")
            }
            checkDebuff(currPlayer: currPlayer, nextPlayer: nextPlayer)
            addToBack(arr: &currPlayer.currDeck)
            checkHealth(currPlayer: nextPlayer)
            checkHealth(currPlayer: currPlayer)
            animateDiscard(currPlayer: currPlayer)
        }
        else
        {
            print("NOT ENOUGH STAMINA HONEY!")
        }

    }

    
    /// Adds a buff card parameter to a players buffArr in appropriate order
    /// Checks to determine if card being replaced is SpellTome/ Blacksmith,
    /// if so undo changes done by SpellTome/ Blacksmith
    ///
    /// - Parameters:
    ///   - newBuff: String representing a buff card
    ///   - currPlayer: Player Object being modified to add buff to buffArr
    func addBuff(newBuff: String, currPlayer: Player)
    {
        //check buff array
        if(currPlayer.buffArr.count == 3)
        {
            //check if replaced is "Spell-Tome-Deck" or "Blacksmith-Deck"
            if(currPlayer.buffArr[0] == "Spell-Tome-Deck" || currPlayer.buffArr[0] == "Blacksmith-Deck")
            {
                currPlayer.attack -= 3
                updateAttackBar(currPlayer: currPlayer)
            }

            //change front 
            currPlayer.buffArr[0] = newBuff
            updateBuffBar(currPlayer: currPlayer)
            //move to back 
            addToBack(arr: &currPlayer.buffArr)         
        }
        else if(currPlayer.buffArr.count >= 0 && currPlayer.buffArr.count < 3)
        {
            //append to end
            currPlayer.buffArr.append(newBuff)
            updateBuffBar(currPlayer: currPlayer)
        }
        else
        {
            print("Error in add buff")
        }

        if currPlayer.attack > 10
        {
            currPlayer.attack = 10
        }
    } 

    /// Check players buffArr and player modify stats based on buff type
    ///
    /// - Parameter currPlayer: PLayer object currently executing turn
    func checkBuffs(currPlayer: Player)
    {
        if currPlayer.buffArr.count > 0
        {
            for i in 0...(currPlayer.buffArr.count - 1)
            {
                let buffCard = currPlayer.buffArr[i]
                switch buffCard
                {
                case "Mana-Potion-Deck", "Liquid-Courage-Deck":
                    currPlayer.attack += 1
                    updateAttackBar(currPlayer: currPlayer)
                    print("buff add attack")
                //+3 attack once while active
                case "Spell-Tome-Deck", "Blacksmith-Deck":
                    //does not take place per turn 
                    print("buff add attack once")
                //+2 health per turn
                case "Health-Potion-Deck":
                    if(currPlayer.canHeal)
                    {
                        currPlayer.health += 2
                        updateHealthBar(currPlayer: currPlayer)
                        print("buff add health")
                    }
                    else
                    {
                        print("Did not heal because Bad-Medicine-Deck debuff is active")
                    }

                    print("buff add health")
                default:
                    print("Error inside checkBuffs")
                }
            }
        }
        if currPlayer.attack > 10
        {
        currPlayer.attack = 10
        }
        checkHealth(currPlayer: currPlayer)
        
    }
    
    
    /// Check health to determine
    /// if health goes above cap - reduce to cap
    /// if health drops to 0 - end game
    /// - Sources:
    /// Delay function obtained from https://stackoverflow.com/questions/38031137/how-to-program-a-delay-in-swift-3
    /// Change view controller function obtained from https://stackoverflow.com/questions/39776929/swift-3-xcode-8-instantiate-view-controller-is-not-working
    ///
    /// - Parameter currPlayer: Player object currently being modified
    func checkHealth(currPlayer: Player)
    {
        //cap player health
        if currPlayer.health > 20
        {
            currPlayer.health = 20
        }
        //player has lost
        if currPlayer.health <= 0
        {
            print("GAME OVER HONEY! Player has died ):")

            lockButtons()

            let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when)
            {
                let storyboard = UIStoryboard(name: "GamePlayingScreen", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier : ("\(currPlayer.name)Loses")) //Using loses instead of wins so that we don't need to send extra parameters to checkHealth function
                self.present(viewController, animated: true)
            }
            
            unlockButtons()
        }
    }

    /// Checks current players debuffs and modifies stats of players
    /// dependent on debuff
    ///
    /// - Parameters:
    ///   - currPlayer: Current Player Object executing turn
    ///   - nextPlayer: Next Player Object to exceute turn
    func checkDebuff(currPlayer: Player, nextPlayer: Player)
    {
        if(currPlayer.debuff == "Bad-Medicine-Deck")
        {
            currPlayer.canHeal = false
        }
        else if(currPlayer.debuff == "Voodoo-Doll-Deck")
        {
            currPlayer.canAddBack = false
        }
        else if(nextPlayer.debuff == "Brass-Knuckles-Deck")
        {
            nextPlayer.bloodThinner = true
        }
    }

    /// Updates players hp stat dependent on damage parameter
    /// Checks for negative attack and modifies to 0
    ///
    /// - Parameters:
    ///   - currPlayer: Current Player object attacking
    ///   - nextPlayer: Next Player Object recieving damage
    ///   - damage: integer damage stat
    func attackDamage(currPlayer: Player, nextPlayer: Player, damage: Int)
    {
        
        if(currPlayer.debuff == "Disarm")
        {
            if(currPlayer.hasAttacked)
            {
                nextPlayer.health -= damage
            }
            else
            {
                //if damage is under 2 then no damage
                //else do damage - 2
                if damage < 2
                {
                    nextPlayer.health -= (0)
                    currPlayer.hasAttacked = true
                }
                else
                {
                    nextPlayer.health -= (damage-2)
                    currPlayer.hasAttacked = true
                }
               
            }
        }
        else
        {
            nextPlayer.health -= damage
        }
    }
    
    
    /// Modify deck array moving first element to end of array
    /// Check and update stamina
    /// Check for debuff preventing change
    ///
    /// - Parameter currPlayer: Player Object whose deck is modified
    func placeBottom(currPlayer: Player)
    {
        if (currPlayer.currStamina >= 1)
        {
            checkDebuff(currPlayer: currPlayer, nextPlayer: currPlayer)
            if(currPlayer.canAddBack)
            {
                currPlayer.currStamina -= 1
                updateStaminaBar(currPlayer: currPlayer)
                print(currPlayer.currDeck)
                addToBack(arr: &currPlayer.currDeck)
                print(currPlayer.currDeck)
                animateDiscard(currPlayer: currPlayer)
            }
            else
            {
                print("Action not performed because Voodoo-Doll-Deck debuff is active")
            }
        }
        else
        {
            print("NOT ENOUGH STAMINA HONEY!")
        }
    }
    
    
    /// Update and stats from various card effects
    /// Reload stats for change of turn
    /// Change turn to next player
    ///
    /// - Parameters:
    ///   - currPlayer: Player object ending turn
    ///   - nextPlayer: Player object beginning turn
    func endTurn(currPlayer: Player, nextPlayer: Player)
    {
        if(currPlayer.totalStamina != 10)
        {
            currPlayer.totalStamina += 2
        }
        currPlayer.currStamina = currPlayer.totalStamina
        updateStaminaBar(currPlayer: currPlayer)
        updateStaminaBar(currPlayer: nextPlayer)
        
        checkDebuff(currPlayer: currPlayer, nextPlayer: nextPlayer)
        
        if(nextPlayer.bloodThinner)
        {
            nextPlayer.health -= 2
            updateHealthBar(currPlayer: nextPlayer)
            checkHealth(currPlayer: nextPlayer)
        }
        if(nextPlayer.debuff == "Disarm-Deck")
        {
            nextPlayer.attack -= 2
            updateAttackBar(currPlayer: nextPlayer)
        }
        if(currPlayer.debuff == "Disarm-Deck")
        {
            currPlayer.attack += 2
            updateAttackBar(currPlayer: currPlayer)
        }
        
        //Keep track of debuff. Debuff can only live for 2 back-and-forth turns.
        if(nextPlayer.debuff != "")
        {
            nextPlayer.debuffTime -= 1
            if (nextPlayer.debuffTime == 0)
            {
                nextPlayer.debuff = ""
                updateDebuffBar(currPlayer: nextPlayer)
                nextPlayer.bloodThinner = false
                nextPlayer.canHeal = true
                nextPlayer.canAddBack = true
            }
        }
        nextPlayer.hasAttacked = false
        checkBuffs(currPlayer: nextPlayer)
    }
    
   
    /// Randomize player deck array
    /// Check and update Stamina
    ///
    /// - Parameter currPlayer: Player Object shuffling deck
    func shuffleCards(currPlayer: Player)
    {
        if (currPlayer.shuffleCount > 0)
        {
            currPlayer.shuffleCount -= 1
            currPlayer.currDeck.shuffle()
            animateShuffle(currPlayer: currPlayer)
        }
        else
        {
            print("No more shuffles!")
        }
    }
    
    ///Locks all of the buttons on the view play game screen except the Menu button
    func lockButtons()
    {
        playCardButton.isEnabled = true
        placeBottomButton.isEnabled = true
        endTurnButton.isEnabled = true
        shuffleButton.isEnabled = true
        topCard1Button.isEnabled = true
        topCard2Button.isEnabled = true
    }
    
    ///Unlocks all of the buttons on the view play game screen except the Menu button
    func unlockButtons()
    {
        playCardButton.isEnabled = false
        placeBottomButton.isEnabled = false
        endTurnButton.isEnabled = false
        shuffleButton.isEnabled = false
        topCard1Button.isEnabled = false
        topCard2Button.isEnabled = false
    }
    
    //TEST PRINTS. Prints all stats
    /*
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
 */
    // END OF FUNCTIONS
    
    //dynamic UI images
    ///Image used for Player 1's Top Card
    @IBOutlet weak var topCard1: UIImageView!
    ///Image used for Player 2's Top Card
    @IBOutlet weak var topCard2: UIImageView!
    ///Image used for Player 1's Health Bar
    @IBOutlet weak var healthBar1: UIImageView!
    ///Image used for Player 1's Attack Bar
    @IBOutlet weak var attackBar1: UIImageView!
    ///Image used for Player 1's Stamina Bar
    @IBOutlet weak var staminaBar1: UIImageView!
    ///Image used for Player 2's Health Bar
    @IBOutlet weak var healthBar2: UIImageView!
    ///Image used for Player 2's Attack Bar
    @IBOutlet weak var attackBar2: UIImageView!
    ///Image used for Player 2's Stamina Bar
    @IBOutlet weak var staminaBar2: UIImageView!
    ///Image used when a Player presses and hold on a top card
    @IBOutlet weak var infoCard: UIImageView!
    ///Image used for when Player 1 discards a card
    @IBOutlet weak var discard1: UIImageView!
    ///Image used for when Player 2 discards a card
    @IBOutlet weak var discard2: UIImageView!
    
    //buff and debuff images
    ///Image used for Player 1's debuff
    @IBOutlet weak var debuffIcon1: UIImageView!
    ///Image used for Player 2's debuff
    @IBOutlet weak var debuffIcon2: UIImageView!
    ///Image used for Player 1's first buff
    @IBOutlet weak var buffIcon1_1: UIImageView!
    ///Image used for Player 1's second buff
    @IBOutlet weak var buffIcon1_2: UIImageView!
    ///Image used for Player 1's third buff
    @IBOutlet weak var buffIcon1_3: UIImageView!
    ///Image used for Player 2's first buff
    @IBOutlet weak var buffIcon2_1: UIImageView!
    ///Image used for Player 2's second buff
    @IBOutlet weak var buffIcon2_2: UIImageView!
    ///Image used for Player 2's third buff
    @IBOutlet weak var buffIcon2_3: UIImageView!
    
    //class images
    ///Image used for Player 1's Class Icon
    @IBOutlet weak var player1Class: UIImageView!
    ///Image used for Player 2's Class Icon
    @IBOutlet weak var player2Class: UIImageView!
    
    ///Image used for the Player Turn Header Label
    @IBOutlet weak var playerTurn: UILabel!
    
    ///Blur effect used when a Top Card  is held
    @IBOutlet weak var blurTopCard: UIVisualEffectView!
    
    ///turn for starts based on flipped coin
    var turn = playerStart;

    //Button Press Actions
    ///Button used for playing a card
    @IBOutlet weak var playCardButton: UIButton!
    ///Button used for placing a card at the bottom of a deck
    @IBOutlet weak var placeBottomButton: UIButton!
    ///Button used for ending the current player's turn
    @IBOutlet weak var endTurnButton: UIButton!
    ///Button used for shuffling the current player's deck
    @IBOutlet weak var shuffleButton: UIButton!
    ///Button used for ending the match
    @IBOutlet weak var surrenderButton: UIButton!
    ///Button used for viewing the Info Card
    @IBOutlet weak var topCard1Button: UIButton!
    ///Button used for viewing the Info Card
    @IBOutlet weak var topCard2Button: UIButton!
    
    ///Function that is called once a player plays a card or moves a card to the bottom of a deck
    /// - Sources:
    ///     - function adapted from https://www.appcoda.com/view-animation-in-swift/
    ///     - function adapted from https://stackoverflow.com/questions/40028035/remove-last-two-characters-in-a-string-swift-3-0
    /// - Parameters:
    ///   - currPlayer: The current Player who is moving their cards
    func animateDiscard(currPlayer: Player)
    {
        //disables buttons for animation duration
        playCardButton.isEnabled = false
        placeBottomButton.isEnabled = false
        shuffleButton.isEnabled = false
        
        if(currPlayer.name == "player1")
        {
            self.discard1.layer.zPosition = 2
            self.topCard1.layer.zPosition = 1
            let discardName = currPlayer.currDeck[19]
            let postfix = discardName.index(discardName.endIndex, offsetBy: -5)
            let truncate = discardName.substring(to: postfix)
            discard1.image = UIImage(named: truncate+"-Single")
            revealTopCard(currPlayer: currPlayer)
            UIView.animate(withDuration: 0.5, animations: {
                var newCenter = self.discard1.center
                newCenter.x -= 300
                self.discard1.center = newCenter
            }, completion: { finished in
                print("Off Screen")
                self.discard1.layer.zPosition = 1
                self.topCard1.layer.zPosition = 2
                UIView.animate(withDuration: 0.5, animations: {
                    var newCenter = self.discard1.center
                    newCenter.x += 300
                    self.discard1.center = newCenter
                }, completion: { finished in
                    print("Discard Animation Complete")
                    self.discard1.image = UIImage(named: "")
                    self.playCardButton.isEnabled = true
                    self.placeBottomButton.isEnabled = true
                    self.shuffleButton.isEnabled = true
                })
            })
        }
        else
        {
            self.discard2.layer.zPosition = 2
            self.topCard2.layer.zPosition = 1
            let discardName = currPlayer.currDeck[19]
            let postfix = discardName.index(discardName.endIndex, offsetBy: -5)
            let truncate = discardName.substring(to: postfix)
            discard2.image = UIImage(named: truncate+"-Single")
            revealTopCard(currPlayer: currPlayer)
            UIView.animate(withDuration: 0.5, animations: {
                var newCenter = self.discard2.center
                newCenter.x += 300
                self.discard2.center = newCenter
            }, completion: { finished in
                print("Off Screen")
                self.discard2.layer.zPosition = 1
                self.topCard2.layer.zPosition = 2
                UIView.animate(withDuration: 0.5, animations: {
                    var newCenter = self.discard2.center
                    newCenter.x -= 300
                    self.discard2.center = newCenter
                }, completion: { finished in
                    print("Discard Animation Complete")
                    self.discard2.image = UIImage(named: "")
                    self.playCardButton.isEnabled = true
                    self.placeBottomButton.isEnabled = true
                    self.shuffleButton.isEnabled = true
                })
            })
        }
    }
    
    ///Function that is called once a player shuffles their deck
    /// - Sources:
    ///     - function adapted from https://www.appcoda.com/view-animation-in-swift/
    ///     - function adapted from https://stackoverflow.com/questions/40028035/remove-last-two-characters-in-a-string-swift-3-0
    /// - Parameters:
    ///   - currPlayer: The current Player who is shuffling their cards
    func animateShuffle(currPlayer: Player)
    {
        //disables buttons for animation duration
        playCardButton.isEnabled = false
        placeBottomButton.isEnabled = false
        shuffleButton.isEnabled = false
        
        if(currPlayer.name == "player1")
        {
            UIView.animate(withDuration: 0.75, animations: {
             var newCenter = self.topCard1.center
             newCenter.x -= 300
             self.topCard1.center = newCenter
             }, completion: { finished in
             print("Off Screen")
                self.revealTopCard(currPlayer: currPlayer)
                UIView.animate(withDuration: 0.75, animations: {
                    var newCenter = self.topCard1.center
                    newCenter.x += 300
                    self.topCard1.center = newCenter
                }, completion: { finished in
                    print("Shuffle Animation Complete")
                    self.playCardButton.isEnabled = true
                    self.placeBottomButton.isEnabled = true
                    self.shuffleButton.isEnabled = true
                })
             })
        }
        else
        {
            UIView.animate(withDuration: 1, animations: {
                var newCenter = self.topCard2.center
                newCenter.x += 300
                self.topCard2.center = newCenter
            }, completion: { finished in
                print("Off Screen")
                self.revealTopCard(currPlayer: currPlayer)
                UIView.animate(withDuration: 1, animations: {
                    var newCenter = self.topCard2.center
                    newCenter.x -= 300
                    self.topCard2.center = newCenter
                }, completion: { finished in
                    print("Shuffle Animation Complete")
                    self.playCardButton.isEnabled = true
                    self.placeBottomButton.isEnabled = true
                    self.shuffleButton.isEnabled = true
                })
            })
        }
    }
    
    ///Function that is called once a player presses and holds Player 1's deck.
    ///This reveals the Info Card and Blur effect.
    /// - Sources:
    ///     - function adapted from https://stackoverflow.com/questions/34548263/button-tap-and-long-press-gesture
    /// - Parameters:
    ///   - sender: Button that is being pressed
    @objc func holdTopCard1(_ sender: UIGestureRecognizer){
        //button released
        if sender.state == .ended {
            infoCard.image = UIImage(named: "")
            blurTopCard.isHidden = true;
        }
        //button pushed down
        else if sender.state == .began {
            infoCard.layer.zPosition = 4
            blurTopCard.layer.zPosition = 3
            let cardName = player1.currDeck[0]
            let postfix = cardName.index(cardName.endIndex, offsetBy: -5)
            let truncate = cardName.substring(to: postfix)
            infoCard.image = UIImage(named: truncate+"-Single")
            blurTopCard.isHidden = false;
        }
    }
    
    ///Function that is called once a player presses and holds Player 2's deck.
    ///This reveals the Info Card and Blur effect.
    /// - Sources:
    ///     - function adapted from https://stackoverflow.com/questions/34548263/button-tap-and-long-press-gesture
    /// - Parameters:
    ///   - sender: Button that is being pressed
    @objc func holdTopCard2(_ sender: UIGestureRecognizer){
        //button released
        if sender.state == .ended {
            infoCard.image = UIImage(named: "")
            blurTopCard.isHidden = true;
        }
        //button pushed down
        else if sender.state == .began {
            infoCard.layer.zPosition = 4
            blurTopCard.layer.zPosition = 3
            let cardName = player2.currDeck[0]
            let postfix = cardName.index(cardName.endIndex, offsetBy: -5)
            let truncate = cardName.substring(to: postfix)
            infoCard.image = UIImage(named: truncate+"-Single")
            blurTopCard.isHidden = false;
        }
    }
    
    ///Array containing strings of all of the possible stamina bars/values
    var staminaBarImages = ["Stamina-Bar0","Stamina-Bar1","Stamina-Bar2","Stamina-Bar3","Stamina-Bar4","Stamina-Bar5","Stamina-Bar6","Stamina-Bar7","Stamina-Bar8","Stamina-Bar9","Stamina-Bar10"]
    ///Array containing strings of all of the possible attack bars/values
    var attackBarImages = ["Attack-Bar0","Attack-Bar1","Attack-Bar2","Attack-Bar3","Attack-Bar4","Attack-Bar5","Attack-Bar6","Attack-Bar7","Attack-Bar8","Attack-Bar9","Attack-Bar10"]
    ///Array containing strings of all of the possible health bars/values
    var healthBarImages = ["Health-Bar0","Health-Bar1","Health-Bar2","Health-Bar3","Health-Bar4","Health-Bar5","Health-Bar6","Health-Bar7","Health-Bar8","Health-Bar9","Health-Bar10","Health-Bar11","Health-Bar12","Health-Bar13","Health-Bar14","Health-Bar15","Health-Bar16","Health-Bar17","Health-Bar18","Health-Bar19","Health-Bar20"]
    
    ///Function that updates the current Player's top card
    /// - Parameters:
    ///   - currPlayer: The current player whose deck needs to be updated
    func revealTopCard(currPlayer: Player)
    {
        if(currPlayer.name == "player1")
        {
            if(topCard1 != nil)
            {
                topCard1.image = UIImage(named: player1.currDeck[0])
            }
        }
        else
        {
            if(topCard2 != nil)
            {
                topCard2.image = UIImage(named: player2.currDeck[0])
            }
        }
    }
    
    ///Function that sets the info card image to whichever card that needs to be expanded
    /// - Parameters:
    ///   - currPlayer: The current player whose top card needs to be displayed as the info card
    func revealInfoCard(currPlayer: Player)
    {
        if(infoCard != nil)
        {
            if(currPlayer.name == "player1")
            {
                infoCard.image = UIImage(named: player1.currDeck[0])
            }
            else
            {
                infoCard.image = UIImage(named: player2.currDeck[0])
            }
        }
    }
    
    ///Function that updates the current Player's debuff icon
    /// - Parameters:
    ///   - currPlayer: The current player whose gaining a debuff
    func updateDebuffBar(currPlayer: Player)
    {
        if(currPlayer.name == "player1")
        {
            if(debuffIcon1 != nil)
            {
                if(currPlayer.debuff == "Disarm-Deck")
                {
                    debuffIcon1.image = UIImage(named: "Disarm-Deck-Icon")
                }
                else if(currPlayer.debuff == "Bad-Medicine-Deck")
                {
                    debuffIcon1.image = UIImage(named: "Bad-Medicine-Deck-Icon")
                }
                else if(currPlayer.debuff == "Voodoo-Doll-Deck")
                {
                    debuffIcon1.image = UIImage(named: "Voodoo-Doll-Deck-Icon")
                }
                else if(currPlayer.debuff == "Brass-Knuckles-Deck")
                {
                    debuffIcon1.image = UIImage(named: "Brass-Knuckles-Deck-Icon")
                }
                else
                {
                    debuffIcon1.image = UIImage(named: "")
                }
            }
        }
        else
        {
            if(debuffIcon2 != nil)
            {
                if(currPlayer.debuff == "Disarm-Deck")
                {
                    debuffIcon2.image = UIImage(named: "Disarm-Deck-Icon")
                }
                else if(currPlayer.debuff == "Bad-Medicine-Deck")
                {
                    debuffIcon2.image = UIImage(named: "Bad-Medicine-Deck-Icon")
                }
                else if(currPlayer.debuff == "Voodoo-Doll-Deck")
                {
                    debuffIcon2.image = UIImage(named: "Voodoo-Doll-Deck-Icon")
                }
                else if(currPlayer.debuff == "Brass-Knuckles-Deck")
                {
                    debuffIcon2.image = UIImage(named: "Brass-Knuckles-Deck-Icon")
                }
                else
                {
                    debuffIcon2.image = UIImage(named: "")
                }
            }
        }
    }
    
    ///Function that updates the current Player's buff icons
    /// - Parameters:
    ///   - currPlayer: The current player whose gaining a buff
    func updateBuffBar(currPlayer: Player)
    {
        if(currPlayer.name == "player1")
        {
            if(buffIcon1_1 != nil && buffIcon1_2 != nil && buffIcon1_3 != nil)
            {
                if(currPlayer.buffArr.count == 1)
                {
                    buffIcon1_1.image = UIImage(named: currPlayer.buffArr[0]+"-Icon")
                }
                else if(currPlayer.buffArr.count == 2)
                {
                    buffIcon1_1.image = UIImage(named: currPlayer.buffArr[0]+"-Icon")
                    buffIcon1_2.image = UIImage(named: currPlayer.buffArr[1]+"-Icon")
                }
                else if(currPlayer.buffArr.count == 3)
                {
                    buffIcon1_1.image = UIImage(named: currPlayer.buffArr[0]+"-Icon")
                    buffIcon1_2.image = UIImage(named: currPlayer.buffArr[1]+"-Icon")
                    buffIcon1_3.image = UIImage(named: currPlayer.buffArr[2]+"-Icon")
                }
                else
                {
                    print("Can't show buffs!")
                }
            }
        }
        else
        {
            if(buffIcon2_1 != nil && buffIcon2_2 != nil && buffIcon2_3 != nil)
            {
                if(currPlayer.buffArr.count == 1)
                {
                    buffIcon2_1.image = UIImage(named: currPlayer.buffArr[0]+"-Icon")
                }
                else if(currPlayer.buffArr.count == 2)
                {
                    buffIcon2_1.image = UIImage(named: currPlayer.buffArr[0]+"-Icon")
                    buffIcon2_2.image = UIImage(named: currPlayer.buffArr[1]+"-Icon")
                }
                else if(currPlayer.buffArr.count == 3)
                {
                    buffIcon2_1.image = UIImage(named: currPlayer.buffArr[0]+"-Icon")
                    buffIcon2_2.image = UIImage(named: currPlayer.buffArr[1]+"-Icon")
                    buffIcon2_3.image = UIImage(named: currPlayer.buffArr[2]+"-Icon")
                }
                else
                {
                    print("Can't show buffs!")
                }
            }
        }
    }
    
    ///Function that updates the current Player's health
    /// - Parameters:
    ///   - currPlayer: The current player whose gaining or losing health
    func updateHealthBar(currPlayer: Player)
    {
        if(currPlayer.name == "player1")
        {
            if(healthBar1 != nil)
            {
                if(currPlayer.health > 20)
                {
                    healthBar1.image = UIImage(named: healthBarImages[20])
                }
                else if(currPlayer.health < 0)
                {
                    healthBar1.image = UIImage(named: healthBarImages[0])
                }
                else
                {
                    healthBar1.image = UIImage(named: healthBarImages[currPlayer.health])
                }
            }
        }
        else
        {
            if(healthBar2 != nil)
            {
                if(currPlayer.health > 20)
                {
                    healthBar2.image = UIImage(named: healthBarImages[20])
                }
                else if(currPlayer.health < 0)
                {
                    healthBar2.image = UIImage(named: healthBarImages[0])
                }
                else
                {
                    healthBar2.image = UIImage(named: healthBarImages[currPlayer.health])
                }
            }
        }
    }
    
    ///Function that updates the current Player's attack
    /// - Parameters:
    ///   - currPlayer: The current player whose gaining or losing attack
    func updateAttackBar(currPlayer: Player)
    {
        if(currPlayer.name == "player1")
        {
            if(attackBar1 != nil)
            {
                if(currPlayer.attack > 10)
                {
                    attackBar1.image = UIImage(named: attackBarImages[10])
                }
                else if(currPlayer.attack < 0)
                {
                    attackBar1.image = UIImage(named: attackBarImages[0])
                }
                else
                {
                    attackBar1.image = UIImage(named: attackBarImages[currPlayer.attack])
                }
            }
        }
        else
        {
            if(attackBar2 != nil)
            {
                if(currPlayer.attack > 10)
                {
                    attackBar2.image = UIImage(named: attackBarImages[10])
                }
                else if(currPlayer.attack < 0)
                {
                    attackBar2.image = UIImage(named: attackBarImages[0])
                }
                else
                {
                    attackBar2.image = UIImage(named: attackBarImages[currPlayer.attack])
                }
            }
        }
    }
    
    ///Function that updates the current Player's stamina
    /// - Parameters:
    ///   - currPlayer: The current player whose gaining or losing stamina
    func updateStaminaBar(currPlayer: Player)
    {
        if(currPlayer.name == "player1")
        {
            if(staminaBar1 != nil)
            {
                if(currPlayer.currStamina > 10)
                {
                    staminaBar1.image = UIImage(named: staminaBarImages[10])
                }
                else if(currPlayer.currStamina < 0)
                {
                    staminaBar1.image = UIImage(named: staminaBarImages[currPlayer.currStamina])
                }
                else
                {
                    staminaBar1.image = UIImage(named: staminaBarImages[currPlayer.currStamina])
                }
            }
        }
        else
        {
            if(staminaBar2 != nil)
            {
                if(currPlayer.currStamina > 10)
                {
                    staminaBar2.image = UIImage(named: staminaBarImages[10])
                }
                else if(currPlayer.currStamina < 0)
                {
                    staminaBar2.image = UIImage(named: staminaBarImages[currPlayer.currStamina])
                }
                else
                {
                    staminaBar2.image = UIImage(named: staminaBarImages[currPlayer.currStamina])
                }
            }
        }
    }


    // TEST SUITE

    //Check for function adding in appropriate order
    /*func runTestAddBuff1()
    {
        let player = Player(name: "Player1")

        addBuff(newBuff: "1", currPlayer: player)
        addBuff(newBuff: "2", currPlayer: player)
        addBuff(newBuff: "3", currPlayer: player)
        addBuff(newBuff: "4", currPlayer: player)
        addBuff(newBuff: "5", currPlayer: player)
        addBuff(newBuff: "6", currPlayer: player)

        let result = player.buffArr
        let expected = ["4", "5", "6"]

        if result == expected
        {
        print("AddBuff1 Test Pass!")
        }
        else
        {
        print("AddBuff1 Test Failed!")
        }
    }*/

    //END TEST SUITE
    
    /// Call on playCard function
    ///
    /// - Parameter sender: Player pressing button
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
        //printStats()
        
    }
    
    /// Call on placeBottom function
    ///
    /// - Parameter sender: Player pressing button
    @IBAction func placeBottomPress(_ sender: Any) {
        
        if (turn == 1)
        {
            placeBottom(currPlayer: player1)
        }
        else if (turn == 2)
        {
            placeBottom(currPlayer: player2) //player1 was here
        }
        else
        {
            print("Error inside placeButtomPress")
        }
        
        //TEST. Show stats
        //printStats()
    }
    

    /// Calls on endTurn function
    /// Replenishes stamina, updates total stamina, and checks for buffs/debuffs
    /// Chenges turn
    ///
    /// - Parameter sender: PLayer pressing button
    @IBAction func endTurnPress(_ sender: Any) {
        /*UIView.animate(withDuration: 1, animations: {
            self.center = CGPointMake(playerTurn.center.x, playerTurn.center.y+400)
        })*/
        if(turn == 1)
        {
            turn = 2
            endTurn(currPlayer: player1, nextPlayer: player2)
            playerTurn.text = "PLAYER 2's Turn"
            
            if(player2.shuffleCount == 2)
            {
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Up-2"), for:.normal);
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Down-2"), for:.highlighted);
            }
            if(player2.shuffleCount == 1)
            {
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Up-1"), for:.normal);
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Down-1"), for:.highlighted);
            }
            if(player2.shuffleCount == 0)
            {
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Up-0"), for:.normal);
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Down-0"), for:.highlighted);
            }
            
            
            //disable the place bottom button
            if(player2.debuff == "Voodoo-Doll-Deck")
            {
                placeBottomButton.setImage(UIImage(named: "PlaceBottom-Up-Disabled"), for:.normal);
                placeBottomButton.setImage(UIImage(named: "PlaceBottom-Down-Disabled"), for:.highlighted);
            }
            else
            {
                placeBottomButton.setImage(UIImage(named: "PlaceBottom-Up"), for:.normal);
                placeBottomButton.setImage(UIImage(named: "PlaceBottom-Down"), for:.highlighted);
            }
        }
        else if(turn == 2)
        {
            turn = 1
            endTurn(currPlayer: player2, nextPlayer: player1)
            playerTurn.text = "PLAYER 1's Turn"
            
            if(player1.shuffleCount == 2)
            {
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Up-2"), for:.normal);
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Down-2"), for:.highlighted);
            }
            if(player1.shuffleCount == 1)
            {
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Up-1"), for:.normal);
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Down-1"), for:.highlighted);
            }
            if(player1.shuffleCount == 0)
            {
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Up-0"), for:.normal);
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Down-0"), for:.highlighted);
            }
            
            
            //disable the place bottom button
            if(player1.debuff == "Voodoo-Doll-Deck")
            {
                placeBottomButton.setImage(UIImage(named: "PlaceBottom-Up-Disabled"), for:.normal);
                placeBottomButton.setImage(UIImage(named: "PlaceBottom-Down-Disabled"), for:.highlighted);
            }
            else
            {
                placeBottomButton.setImage(UIImage(named: "PlaceBottom-Up"), for:.normal);
                placeBottomButton.setImage(UIImage(named: "PlaceBottom-Down"), for:.highlighted);
            }
        }
        else
        {
            print("Error inside endTurnPress!")
        }
        
        //TEST. Show stats
        //printStats()
    }
    
    
    /// Call on shuffleCards function and update players shuffleCount stat
    ///
    /// - Parameter sender: Player pressing button
    @IBAction func shufflePress(_ sender: Any) {
        if (turn == 1)
        {
            shuffleCards(currPlayer: player1)
            
            //check the number of shuffles a player has and update the image
            if(player1.shuffleCount == 2)
            {
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Up-2"), for:.normal);
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Down-2"), for:.highlighted);
            }
            if(player1.shuffleCount == 1)
            {
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Up-1"), for:.normal);
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Down-1"), for:.highlighted);
            }
            if(player1.shuffleCount == 0)
            {
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Up-0"), for:.normal);
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Down-0"), for:.highlighted);
            }
        }
        else if (turn == 2)
        {
            //check the number of shuffles a player has and update the image

            
            shuffleCards(currPlayer: player2)
            
            if(player2.shuffleCount == 2)
            {
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Up-2"), for:.normal);
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Down-2"), for:.highlighted);
            }
            if(player2.shuffleCount == 1)
            {
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Up-1"), for:.normal);
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Down-1"), for:.highlighted);
            }
            if(player2.shuffleCount == 0)
            {
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Up-0"), for:.normal);
                shuffleButton.setImage(UIImage(named: "ShuffleButton-Down-0"), for:.highlighted);
            }
        }
        else
        {
            print ("Error inside shufflePress!")
        }
        
        //TEST. Show stats
        //printStats()
    }
    ///Function that ends the game
    /// - Parameters:
    ///   - sender: Surrender button is pressed
    @IBAction func surrenderPress(_ sender: Any) {
    }
    ///Function that tests different aspects of the game
    /// - Parameters:
    ///   - sender: Test button is pressed
    @IBAction func testPress(_ sender: Any) {
        //runTestAddBuff1()
    }
}

///Class that contains the coin flip screen.
class CoinFlip: UIViewController {
    
    ///Image used for the coin. Either Heads or Tails
    @IBOutlet weak var coinImage: UIImageView!
    ///Label used for indicating which player starts based of the coin flip
    @IBOutlet weak var playerStartText: UILabel!
    ///Button that hides the flip coin button
    @IBOutlet weak var flipVisibility: UIButton!
    ///Button that shows the next button
    @IBOutlet weak var nextVisibility: UIButton!
    //nextVisibility.isHidden = true;
    
    /// Function that flips a coin
    ///
    /// - Parameter sender: Player pressing button
    @IBAction func flipCoin(_ sender: Any) {
        let coinFlip = Int(arc4random_uniform(2))
        print ("Coin Result: \(coinFlip)")
        
        if(coinFlip == 1)
        {
            coinImage.image = UIImage(named: "Heads");
            playerStartText.text="Player 1 Starts!";
            flipVisibility.isHidden = true;
            nextVisibility.isHidden = false;
            playerStart = 1;
        }
        else
        {
            coinImage.image = UIImage(named: "Tails");
            playerStartText.text="Player 2 Starts!";
            flipVisibility.isHidden = true;
            nextVisibility.isHidden = false;
            playerStart = 2;
        }
        
    }
}



