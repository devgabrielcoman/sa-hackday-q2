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
    var keyframes: [String] = []
    var selectedKeyframe = 0
    
    //
    // public callbacks
    public var didSelectKeyframe: ((Int) -> Void)?
    public var didAddNewKeyframe: ((Void) -> Void)?
    
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
            
            //
            // new value in the keyframes
            let newValue = "Kf \(keyframes.count + 1)"
            
            //
            // add data
            keyframes.append(newValue)
            
            //
            // update
            rxCollectionView?.update(withData: keyframes)
            
            //
            // send keyframe message
            didAddNewKeyframe?()
            
            //
            // always set the last created keyframe as selected
            setSelectedKeyframe(atIndex: keyframes.count - 1)
        }
    }
    
    func setSelectedKeyframe(atIndex i: Int) {
        self.selectedKeyframe = i
        self.didSelectKeyframe?(self.selectedKeyframe)
        self.collectionView.reloadData()
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
                .set(sizeForCellWithReuseIdentifier: KeyframeCell.Indentifier, { (index, model: String) -> CGSize in
                    return CGSize(width: 32, height: 32)
                })
                .customise(cellForReuseIdentifier: KeyframeCell.Indentifier) { (index, cell: KeyframeCell, model: String) in
                    cell.keyframeLabel.text = model
                    cell.backgroundColor = index.row == self.selectedKeyframe ? UIColor.lightGray : UIColor.white
                }
                .did(clickOnCellWithReuseIdentifier: KeyframeCell.Indentifier) { (index, model: String) in
                    self.setSelectedKeyframe(atIndex: index.row)
                }
            
            break
        }
    }
}
