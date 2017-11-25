//
//  deckPopup.swift
//  Project 3
//
//  Created by James Glass on 11/23/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

class deckPopup: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
}
