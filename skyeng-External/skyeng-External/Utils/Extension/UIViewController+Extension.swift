//
//  UIViewController+Extension.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import UIKit

extension UIViewController {

    @discardableResult
    static func instanciated(inStoryboard: StoryboardName) -> Self {
        let storyBoard = UIStoryboard(name: inStoryboard.rawValue, bundle: Bundle.main)
        let id = String(describing: self)
        if #available(iOS 13.0, *) {
            return storyBoard.instantiateViewController(identifier: id) as! Self
        } else {
            return storyBoard.instantiateViewController(withIdentifier: id) as! Self
        }
    }
     
    func topMostViewController() -> UIViewController {
        if let navigation = self as? UINavigationController, let visibleVC = navigation.visibleViewController {
            return visibleVC.topMostViewController()
        }
        
        if let tab = self as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        
        guard let presentedVC = self.presentedViewController else {
            return self
        }
        
        if let navigation = presentedVC as? UINavigationController, let visibleVC = navigation.visibleViewController {
            return visibleVC.topMostViewController()
        }
        
        if let tab = presentedVC as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return presentedVC.topMostViewController()
    }
    
}
