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

    @IBOutlet weak var backgroundView: UIImageView!
    fileprivate var isBackgroundSelected: Bool = true
    
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
    
    let size = UIScreen.main.bounds.size.width - 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // make background visible
        self.backgroundView.layer.opacity = 1
    }
}

//
// Logic
extension DrawingController {
    
    public func getCurrentImages () -> [UIImage] {
        return images.map { imageview -> UIImage in
            return imageview.image!
        }
    }
    
    public func getBackground () -> UIImage? {
        return backgroundView.image
    }
    
    public func showBackground () {
        self.isBackgroundSelected = true
        self.backgroundView.layer.opacity = 1
        
        //
        //
        images.forEach { img in
            img.layer.opacity = 0
        }
    }
    
    public func addNewImage () {
    
        let frame = CGRect(x: 0, y: 0, width: size, height: size)
        
        //
        // create the image
        let imageView = UIImageView(frame: frame)
        imageView.backgroundColor = UIColor.clear
        imageView.layer.opacity = 0
        
        //
        // set first image
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        context?.setFillColor(UIColor.red.cgColor)
        context?.fillPath()
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //
        // add image
        self.view.addSubview(imageView)
        
        //
        // add to array
        images.append(imageView)
    }
    
    public func selectImage(atIndex i: Int) {
        
        //
        // make this
        isBackgroundSelected = false
        backgroundView.layer.opacity = 0.1
        
        //
        // validate
        if (i >= images.count || i < 0) {
            //
            // just select the background
            isBackgroundSelected = true
            backgroundView.layer.opacity = 1
            return
        }
        
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
    
    public func copyImage(atOriginalIndex i: Int, intoNewIndex j: Int) {
        
        //
        // validate
        if (i >= images.count || i < 0) {
            return
        }
        
        let frame = CGRect(x: 0, y: 0, width: size, height: size)
        let imageView = UIImageView(frame: frame)
        imageView.backgroundColor = UIColor.clear
        imageView.layer.opacity = 0
        imageView.image = images[i].image
        self.view.addSubview(imageView)
        images.insert(imageView, at: j)
    }
    
    public func deleteImage(atIndex i: Int) {
        
        //
        // validate
        if (i >= images.count || i < 0) {
            return
        }
        
        let image = images[i]
        image.removeFromSuperview()
        images.remove(at: i)
        selectImage(atIndex: i - 1)
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
        
        var drawingView: UIImageView! = nil
        
        if images.count <= 0 || isBackgroundSelected {
            drawingView = backgroundView
        } else {
            drawingView = images[self.selectedImage]
        }
        
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
}

//
// State
extension DrawingController {
    
}
