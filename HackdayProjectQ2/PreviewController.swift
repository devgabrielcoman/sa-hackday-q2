//
//  PreviewController.swift
//  HackdayProjectQ2
//
//  Created by Gabriel Coman on 30/06/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

import UIKit

//
// Basic
class PreviewController: BaseController {

    @IBOutlet weak var previewView: UIImageView!
    fileprivate var images: [UIImage] = []
    
    var timer = Timer()
    
    fileprivate var currentImage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preview()
    }
}

//
// Business Logic
extension PreviewController {
    
    func setImages(_ images: [UIImage]) {
        self.images = images
    }
    
    func preview() {
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
    }
    
    func timerFunc () {
        
        if images.count <= 0 {
            return
        }
        
        if !(currentImage < images.count) {
            currentImage = 0
        }
        
        let image = images[currentImage]
        previewView.image = image
        currentImage += 1
    }
}
