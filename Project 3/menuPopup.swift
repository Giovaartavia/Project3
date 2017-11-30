//
//  deckPopup.swift
//  Project 3
//
//  Created by James Glass on 11/23/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

/// Class that shows the menu as a popup while hiding background by making it a darker color.
class menuPopup: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    /// Closes the popup when pressed.
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
}
