//
//  OnlineCoinFlip.swift
//  Project 3
//
//  Created by Brandon Lammey on 11/20/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

///Class that contains the coin flip screen.
class OnlineCoinFlip: UIViewController {
    
    //multipeer connectivity manager
    let screenService = ScreenServiceManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        screenService.delegate = self
    }
    
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
        //print ("Coin Result: \(coinFlip)")
        
        if(coinFlip == 1)
        {
            screenService.send(screenName: "start1")
            coinImage.image = UIImage(named: "Heads");
            playerStartText.text="Player 1 Starts!";
            flipVisibility.isHidden = true;
            nextVisibility.isHidden = false;
            playerStart = 1;
        }
        else
        {
            screenService.send(screenName: "start2")
            coinImage.image = UIImage(named: "Tails");
            playerStartText.text="Player 2 Starts!";
            flipVisibility.isHidden = true;
            nextVisibility.isHidden = false;
            playerStart = 2;
        }
        
    }
    
    /// Function that pushes the flipped coin result to all other players
    ///
    /// - Parameter coinStatus: State of the coin
    func onlineCoinFlip(coinStatus: String)
    {
        if(coinStatus == "start1")
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
    
    /// Function sends string using MultiPeer connectivity
    ///
    /// - Parameter sender: Player pressing button
    @IBAction func coinFlipNext(_ sender: Any)
    {
        screenService.send(screenName: "next")
    }
    
    /// Function moves screen to OnlineGamePLayingScreen view controller
    func coinFlipNextOnline()
    {
        let storyboard = UIStoryboard(name: "OnlineGamePlayingScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier : ("cardDraft"))
        self.present(viewController, animated: true)
    }
    
}


///extends OnlineViewPLayGame to add in ScreenServiceManager MultiPeer functions
extension OnlineCoinFlip : ScreenServiceManagerDelegate
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
                //determine which btton was pressed and push changes to all screens
                switch screenString
                {
                case "start1":
                    //self.flipCoin(self)
                    self.onlineCoinFlip(coinStatus: "start1")
                case "start2":
                    //self.flipCoin(self)
                    self.onlineCoinFlip(coinStatus: "start2")
                case "next" :
                    self.coinFlipNextOnline()
                    
                default:
                    NSLog("%@", "Unknown value received: \(screenString)")
                }
                
        }
    }
    
}
