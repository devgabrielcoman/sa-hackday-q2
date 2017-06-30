//
//  BaseController.swift
//  HackdayProjectQ2
//
//  Created by Gabriel Coman on 30/06/2017.
//  Copyright © 2017 Gabriel Coman. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BaseController: UIViewController {

    let disposeBag = DisposeBag ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BaseController {
    
    func getChild <T: UIViewController> () -> T? {
        
        var childVC: T?
        
        self.childViewControllers.forEach { child in
            if let child = child as? T {
                childVC = child
            }
        }
        
        return childVC
    }
}
