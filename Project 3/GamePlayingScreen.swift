//
//  PlsWork.swift
//  Project 3
//
//  Created by Giovanni on 10/24/17.
//  Copyright © 2017 Memory Leeks. All rights reserved.
//

import Foundation
import UIKit

class ViewPlayGame: UIViewController {
    @IBOutlet weak var metal: UIImageView!
    @IBAction func buttonIsPressed(_ sender: Any)
    {
        self.metal.isHidden = true
    }
}

