//
//  Keyframe+Cells.swift
//  HackdayProjectQ2
//
//  Created by Gabriel Coman on 30/06/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

import UIKit

class KeyframeCell: UICollectionViewCell {
    
    @IBOutlet weak var keyframeLabel: UILabel!
    
    public static let Indentifier = "KeyframeCellId"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
    }
    
    
}
