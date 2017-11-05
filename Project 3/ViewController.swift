//
//  ViewController.swift
//  Project 3
//
//  Created by Giovanni, Brandon, Dylan, James on 10/24/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import UIKit

/// Class for view controllers. Handles some warnings. Mainly used when we were learning swift.
class ViewController: UIViewController {
    
    @IBAction func options(_ sender: Any) {
    }

    @IBOutlet weak var optionsButton: UIButton!
    
    override func viewDidLoad() { //Runs when screen is loaded
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.optionsButton.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

