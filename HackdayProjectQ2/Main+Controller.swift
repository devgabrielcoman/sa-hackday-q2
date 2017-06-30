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
    
    @IBAction func submitCreation(_ sender: Any) {
        self.performSegue(withIdentifier: "MainToPreview", sender: self)
    }
    
    @IBAction func eraseAction(_ sender: Any) {
        let drawingController: DrawingController? = self.getChild()
        drawingController?.setCurrentColor(UIColor.white)
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
    
    func embed(controller3: KeyframeController) {
        controller3.didAddNewKeyframe = {
            let drawingController: DrawingController? = self.getChild()
            drawingController?.addNewImage()
        }
        
        controller3.didSelectKeyframe = { keyframe in
            let drawingController: DrawingController? = self.getChild()
            drawingController?.selectImage(atIndex: keyframe)
        }
        
        controller3.didCopyKeyframe = { original, new in
            let drawingController: DrawingController? = self.getChild()
            drawingController?.copyImage(atOriginalIndex: original, intoNewIndex: new)
        }
        
        controller3.didDeleteKeyframe = { keyframe in
            let drawingController: DrawingController? = self.getChild()
            drawingController?.deleteImage(atIndex: keyframe)
        }
    }
    
    func goto(controller: PreviewController) {
        let drawingController: DrawingController? = self.getChild()
        let images = drawingController?.getCurrentImages()
        controller.setImages(images!)
    }
}

