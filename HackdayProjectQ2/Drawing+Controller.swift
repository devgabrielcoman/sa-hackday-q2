//
//  DrawingController.swift
//  HackdayProjectQ2
//
//  Created by Gabriel Coman on 30/06/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

import UIKit
import QuartzCore

//
// Base
class DrawingController: BaseController {

    //
    // array of images to draw on
    fileprivate var selectedImage: Int = 0
    fileprivate var images: [UIImageView] = []
    
    //
    // drawing state
    var drawingColor: UIColor = UIColor.black
    var lastPoint = CGPoint.zero
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//
// Logic
extension DrawingController {
    
    public func addNewImage () {
        //
        // create the image
        let image = UIImageView(frame: self.view.frame)
        image.backgroundColor = UIColor.clear
        image.layer.opacity = 0
        self.view.addSubview(image)
        
        //
        // add to array
        images.append(image)
    }
    
    public func selectImage(atIndex i: Int) {
        
        //
        // previous images
        for j in 0..<i {
            images[j].layer.opacity = 0
        }
        
        //
        // previous image
        if i > 0 {
            images[i-1].layer.opacity = 0.1
        }
        
        // 
        // selected image
        self.selectedImage = i
        images[i].layer.opacity = 1
        
        //
        // next images
        for j in i+1..<images.count {
            images[j].layer.opacity = 0
        }
    }
    
    public func setCurrentColor(_ color: UIColor) {
        self.drawingColor = color
    }
    
    public func setBrushSize (_ size: Int) {
        self.brushWidth = CGFloat(size)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }

    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        let drawingView = images[self.selectedImage]
        
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        drawingView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        // 2
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        
        // 3
        context?.setLineCap(.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(drawingColor.cgColor)
        context?.setBlendMode(.normal)
        
        // 4
        context?.strokePath()
        
        // 5
        drawingView.image = UIGraphicsGetImageFromCurrentImageContext()
        drawingView.alpha = opacity
        UIGraphicsEndImageContext()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 6
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: view)
            drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
            
            // 7
            lastPoint = currentPoint
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            // draw a single point
            drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
        }
        
        let drawingView = images[self.selectedImage]
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(drawingView.frame.size)
        drawingView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: .normal, alpha: 1.0)
        drawingView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: .normal, alpha: opacity)
        drawingView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}

//
// State
extension DrawingController {
    
}
