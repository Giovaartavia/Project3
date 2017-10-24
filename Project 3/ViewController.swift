//
//  ViewController.swift
//  Project 3
//
//  Created by Giovanni on 10/21/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func start(_ sender: Any) {
        //Hide buttons
        //self.optionsButton.isHidden = true
        //self.startButton.isHidden = true
        
        //Center electric card and show it
        //self.electric.center.x = 500.0 //Not working?
        //self.electric.center.y = 300.0
        //self.electric.center = CGPoint(x:178.0, y:390.0)
        //self.electric.isHidden = false
    }
    @IBAction func options(_ sender: Any) {
    }
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var optionsButton: UIButton!
    //@IBOutlet weak var electric: UIImageView!
    
    
    override func viewDidLoad() { //Runs when screen is loaded
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.electric.isHidden = true //Hides the electric pokemon card at startup
        self.startButton.isHidden = false
        self.optionsButton.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

