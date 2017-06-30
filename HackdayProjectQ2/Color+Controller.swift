//
//  ColorController.swift
//  HackdayProjectQ2
//
//  Created by Gabriel Coman on 30/06/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxTableAndCollectionView

enum ColorState {
    case initial
}

class ColorController: BaseController {

    public var selectColor: ((UIColor) -> ())?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var rxCollectionView: RxCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // start in initial state
        setState(ColorState.initial)
        
        //
        // populate data
        getColors()
    }
}

//
// Logic
extension ColorController {
    
    func getColors() {
        
        
        
        // get data
        let colors: [ColorModel] = [
            ColorModel(color: UIColor(colorLiteralRed: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 195/255.0, green: 6/255.0, blue: 6/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 255/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 255/255.0, green: 120.0/255.0, blue: 0.0/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 255/255.0, green: 186/255.0, blue: 39/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 253/255.0, green: 194/255.0, blue: 68/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 255/255.0, green: 255/255.0, blue: 0.0/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 227/255.0, green: 229/255.0, blue: 68/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 136/255.0, green: 229/255.0, blue: 69/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 99/255.0, green: 215/255.0, blue: 13/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 83/255.0, green: 171/255.0, blue: 19/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 71/255.0, green: 244/255.0, blue: 91/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 33/255.0, green: 150/255.0, blue: 243/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 13/255.0, green: 101/255.0, blue: 169/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 0.0/255.0, green: 54/255.0, blue: 255/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 255/255.0, green: 0.0/255.0, blue: 139/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 249/255.0, green: 187/255.0, blue: 221/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)),
            ColorModel(color: UIColor(colorLiteralRed: 150/255.0, green: 98/255.0, blue: 64/255.0, alpha: 1))
        ]
        
        // update
        rxCollectionView?.update(withData: colors)
    }
}

//
// State
extension ColorController {
    func setState(_ state: ColorState) {
        switch state {
        case .initial:
            
            // setup collection view
            rxCollectionView = RxCollectionView.create()
                .bind(toCollection: self.collectionView)
                .set(edgeInsets: { section -> UIEdgeInsets in
                    return UIEdgeInsets.zero
                })
                .set(sizeForCellWithReuseIdentifier: ColorCell.Identifier) { (index, model: ColorModel) -> CGSize in
                    return CGSize(width: 32, height: 32)
                }
                .customise(cellForReuseIdentifier: ColorCell.Identifier) { (index, cell: ColorCell, model: ColorModel) in
                    cell.backgroundColor = model.color
                }
                .did(clickOnCellWithReuseIdentifier: ColorCell.Identifier) { (index, model: ColorModel) in
                    self.selectColor?(model.color)
                }
            
            break
        }
    }
}
