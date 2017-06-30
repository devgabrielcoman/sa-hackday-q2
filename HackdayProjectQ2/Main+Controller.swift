//
//  ViewController.swift
//  HackdayProjectQ2
//
//  Created by Gabriel Coman on 30/06/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

import UIKit

class MainController: BaseController {
    
    @IBOutlet weak var brushSizeContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//
// Business Logic 
extension MainController {
    
    @IBAction func toggleBrushSizeContainer(_ sender: Any) {
        brushSizeContainer.isHidden = !brushSizeContainer.isHidden
    }
}

//
// State
extension MainController {
    
}

//
// Routing
extension MainController: MainRoutingLogic {
    
    func embed(controller1: ColorController) {
        controller1.selectColor = { color in
            let drawingController: DrawingController? = self.getChild()
            drawingController?.setCurrentColor(color)
        }
    }
    
    func embed(controller2: BrushSizeController) {
        controller2.selectBrushSize = { size in
            let drawingController: DrawingController? = self.getChild()
            drawingController?.setBrushSize(size)
        }
    }
}

