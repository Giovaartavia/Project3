//
//  Main.swift
//  Project 3
//
//  Created by Giovanni, Brandon, Dylan, James on 10/24/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

///Class for the tutorial screen. Handles what tutorial image is visible.
class Tutorial: UIViewController {
    
    ///Image the shows a tutorial page
    @IBOutlet weak var TutorialImage: UIImageView!
    let tutorialArray = ["Tutorial1","Tutorial2","Tutorial3","Tutorial4","Tutorial5","Tutorial6","Tutorial7","Tutorial8","Tutorial9"];
    var loc = 0;
    
    ///Function that moves the tutorial image to the previous image
    @IBAction func PrevScreen(_ sender: Any) {
        //print("PREV")
        if(loc == 0)
        {
            loc = 8;
        }
        else
        {
            loc = loc-1;
        }
        TutorialImage.image = UIImage(named: tutorialArray[loc]);
    }
    
    ///Function that moves the tutorial image to the next image
    @IBAction func NextScreen(_ sender: Any) {
        //print("NEXT")
        if(loc == 8)
        {
            loc = 0;
        }
        else
        {
            loc = loc+1;
        }
        TutorialImage.image = UIImage(named: tutorialArray[loc]);
    }
    
}
