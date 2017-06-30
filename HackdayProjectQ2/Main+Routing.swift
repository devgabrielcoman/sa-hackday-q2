//
//  MainRouting.swift
//  HackdayProjectQ2
//
//  Created by Gabriel Coman on 30/06/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

import UIKit

protocol MainRoutingLogic {
    func embed(controller1: ColorController)
    func embed(controller2: BrushSizeController)
    func embed(controller3: KeyframeController)
}

extension MainController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let embed = segue.destination as? ColorController {
            self.embed(controller1: embed)
        }
        
        if let embed = segue.destination as? BrushSizeController {
            self.embed(controller2: embed)
        }
        
        if let embed = segue.destination as? KeyframeController {
            self.embed(controller3: embed)
        }
    }
}
