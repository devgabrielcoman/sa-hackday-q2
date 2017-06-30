//
//  KeyframeController.swift
//  HackdayProjectQ2
//
//  Created by Gabriel Coman on 30/06/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxTableAndCollectionView

enum KeyframeState {
    case initial
}

//
// Base
class KeyframeController: BaseController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var rxCollectionView: RxCollectionView?
    
    let maxKeyframes = 20
    var keyframes: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // set initial state
        setState(KeyframeState.initial)
        
        //
        // populate with initial data
        getInitialData()
    }
}

//
// Logic
extension KeyframeController {
    
    func getInitialData() {
        addNewKeyframe()
    }
    
    @IBAction func addKeyframe(_ sender: Any) {
        addNewKeyframe()
    }
    
    func addNewKeyframe () {
        if keyframes.count < maxKeyframes {
            keyframes.append(keyframes.count + 1)
            rxCollectionView?.update(withData: keyframes)
        }
    }
}

//
// State
extension KeyframeController {
 
    func setState (_ state: KeyframeState) {
        switch state {
        case .initial:
            
            self.rxCollectionView = RxCollectionView.create()
                .bind(toCollection: self.collectionView)
                .set(edgeInsets: { section -> UIEdgeInsets in
                    return UIEdgeInsets.zero
                })
                .set(sizeForCellWithReuseIdentifier: KeyframeCell.Indentifier, { (index, model: Int) -> CGSize in
                    return CGSize(width: 32, height: 32)
                })
                .customise(cellForReuseIdentifier: KeyframeCell.Indentifier) { (index, cell: KeyframeCell, model: Int) in
                    cell.keyframeLabel.text = "\(model)"
                }
                .did(clickOnCellWithReuseIdentifier: KeyframeCell.Indentifier) { (index, model: Int) in
                    // do nothing
                }
            
            break
        }
    }
}
