//
//  BrushSizeController.swift
//  HackdayProjectQ2
//
//  Created by Gabriel Coman on 30/06/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

import UIKit

//
// Base
class BrushSizeController: BaseController {

    @IBOutlet weak var brushLabel: UILabel!
    
    public var selectBrushSize: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = 4
        self.view.layer.borderColor = UIColor.black.cgColor
        self.view.layer.borderWidth = 1
    }
}

//
// Business Logic
extension BrushSizeController {
    
    @IBAction func valueChanged(_ sender: UISlider) {
        
        let value = Int(sender.value)
        brushLabel.text = "\(value)"
        self.selectBrushSize?(value)
    }
}
