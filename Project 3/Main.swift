//
//  Main.swift
//  Project 3
//
//  Created by James Glass on 11/1/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

class Tutorial: UIViewController {
    
    @IBOutlet weak var TutorialImage: UIImageView!
    let tutorialArray = ["Tutorial1","Tutorial2","Tutorial3","Tutorial4","Tutorial5","Tutorial6","Tutorial7"];
    var loc = 0;
    
    
    
    @IBAction func PrevScreen(_ sender: Any) {
        //print("PREV")
        if(loc == 0)
        {
            loc = 6;
        }
        else
        {
            loc = loc-1;
        }
        TutorialImage.image = UIImage(named: tutorialArray[loc]);
    }
    
    @IBAction func NextScreen(_ sender: Any) {
        //print("NEXT")
        if(loc == 6)
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
