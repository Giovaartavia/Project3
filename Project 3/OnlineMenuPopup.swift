//
//  OnlineMenuPopup.swift
//  Project 3
//
//  Created by Giovanni on 11/27/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

/// Class that shows the online menu as a popup while hiding background by making it a darker color.
class OnlineMenuPopup: UIViewController {
    
    //multipeer connectivity manager
    let screenService = ScreenServiceManager()
    
    /// Executed when the popup is loaded. Changes the background color and initialized the multipeer service.
    override func viewDidLoad()
    {
        print("********** Online HERE **********")
        print("********** Online HERE **********")
        print("********** Online HERE **********")
        print("********** Online HERE **********")
        print("********** Online HERE **********")
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        super.viewDidLoad()
        screenService.delegate = self
    }
    
    /// Closes the popup when pressed.
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    /// Executed when the "quit" button is pressed. Calls screenChanged from the class extension, giving it the string of "surrender".
    @IBAction func onlineSurrenderButtonPress(_ sender: Any) {
        print("********** Quit Pressed HERE **********")
        print("********** Quit Pressed HERE **********")
        print("********** Quit Pressed HERE **********")
        print("********** Quit Pressed HERE **********")
        print("********** Quit Pressed HERE **********")
        screenService.send(screenName: "Surrender")
    }
    
    /// Changes the ViewController on connected device.
    func onlineSurrender()
    {
        print("********** Function Executed HERE **********")
        print("********** Function Executed HERE **********")
        print("********** Function Executed HERE **********")
        print("********** Function Executed HERE **********")
        print("********** Function Executed HERE **********")
        
        let storyboard = UIStoryboard(name: "OnlineGamePlayingScreen", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier : ("surrenderScreen"))
        self.present(viewController, animated: true)
    }
    
}

/// Online extension for OnlineMenuPopup. Checks the execution from the connected device and either sends an error message or calls the appropriate function.
extension OnlineMenuPopup : ScreenServiceManagerDelegate
{
    func connectedDevicesChanged(manager: ScreenServiceManager, connectedDevices: [String])
    {
        OperationQueue.main.addOperation
            {
                //self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    /// Checks if proper string was given from device to device. If screen is proper, call onlineSurrender function.
    func screenChanged(manager: ScreenServiceManager, screenString: String)
    {
        NSLog("********** HERE **********")
        NSLog("********** HERE **********")
        NSLog("********** HERE **********")
        NSLog("********** HERE **********")
        NSLog("********** HERE **********")
        OperationQueue.main.addOperation
            {
                //determine which btton was pressed and push changes to all screens
                if (screenString == "Surrender")
                {
                    self.onlineSurrender()
                }
                else
                {
                    NSLog("%@", "Unknown value received: \(screenString)")
                }
        }
    }
}
