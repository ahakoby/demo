//
//  BaseViewController.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
import RxCocoa
import RxSwift

class BaseViewController: UIViewController, HasDisposeBag {
    
    var isPrefersLargeTitles: Bool {
        return true
    }

    var isPrefersStatusBarHidden: Bool {
        return true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log.initOf(self)
    }
    
    deinit {
        Log.deinitOf(self)
    }
    
    override var prefersStatusBarHidden: Bool {
        return isPrefersStatusBarHidden
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BaseStyles.defaultBackgroundView.apply(to: view)
        
        removeBackItemTitle()

        // hide the back button text
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        if let navigation = self.navigationController {
            navigation.navigationBar.prefersLargeTitles = isPrefersLargeTitles
            navigation.navigationBar.isTranslucent = true
            navigation.view.backgroundColor = .clear
            navigation.navigationBar.tintColor = .defaultTextColor
            navigation.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.defaultTextColor]
            navigation.navigationBar.standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.defaultTextColor]
        }

        bindUI()
        bindTexts()
        bindStyles()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public func bindStyles() {
        
    }
    
    public func bindTexts() {
        
    }
    
    public func bindUI() {
        
    }
}

extension BaseViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    func removeBackItemTitle() {
        let backItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.backBarButtonItem = backItem
    }
}
