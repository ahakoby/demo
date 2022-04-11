//
//  BaseNavigationViewController.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
        
    init(rootViewController: UIViewController, isNavigationBarHidden: Bool = false) {
        super.init(rootViewController: rootViewController)
        self.isNavigationBarHidden = isNavigationBarHidden
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // #dev Replace with fatalError in Logger.swift after implementing InnerError. A.H.
        fatalError("init(coder:) has not been implemented")
    }
}
