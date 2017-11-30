//
//  OnlineMenuPopup.swift
//  Project 3
//
//  Created by Giovanni on 11/27/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

class OnlineMenuPopup: UIViewController {
    
    //multipeer connectivity manager
    let screenService = ScreenServiceManager()
    
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
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    @IBAction func onlineSurrenderButtonPress(_ sender: Any) {
        print("********** Quit Pressed HERE **********")
        print("********** Quit Pressed HERE **********")
        print("********** Quit Pressed HERE **********")
        print("********** Quit Pressed HERE **********")
        print("********** Quit Pressed HERE **********")
        screenService.send(screenName: "Surrender")
    }
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

extension OnlineMenuPopup : ScreenServiceManagerDelegate
{
    func connectedDevicesChanged(manager: ScreenServiceManager, connectedDevices: [String])
    {
        OperationQueue.main.addOperation
            {
                //self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
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
