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
            ColorModel(color: UIColor.white),
            ColorModel(color: UIColor.black),
            ColorModel(color: UIColor.red),
            ColorModel(color: UIColor.green),
            ColorModel(color: UIColor.blue),
            ColorModel(color: UIColor.magenta),
            ColorModel(color: UIColor.yellow)
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
