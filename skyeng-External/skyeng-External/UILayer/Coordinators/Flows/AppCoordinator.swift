//
//  AppCoordinator.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import UIKit
import SwiftMessages

final class AppCoordinator: CoordinatorType, CoordinatorDelegate {
    var delegate: CoordinatorDelegate?
    var childCoordinators: [CoordinatorType] = []
    var activityIndicatorView: UIActivityIndicatorView? = nil

    var window: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    var root: UIViewController? {
        get {
            return self.window?.rootViewController
        }
        set {
            self.window?.rootViewController = newValue
        }
    }
    
    @MainActor @discardableResult
    func execute(step: CoordinatorStepType) -> Bool {
        guard let appStep = step as? AppStep else {
            return self.cascade(step: step)
        }
        
        // #dev In this switch check, we can group the steps that requires `present` and those that require `push`.
        // And handle those that needs extra params to be passed. A.H
        switch appStep {
        case .loading                          :showLoading()
        case .search                           :showSearch()
        case .toggleLoading(let isLoading)     :toggleLoading(isLoading: isLoading)
        case .presentError(let error)          :presentError(error: error)
        }
        return true
    }
    
    fileprivate func showSearch() {
        let searchVC = Dependency.shared.resolver.resolve(SearchViewController.self)!
        let snvc = BaseNavigationController(rootViewController: searchVC)
        let searchFlow = SearchCoordinator(navigationController: snvc, delegate: self)

        self.add(childCoordinator: searchFlow)
        self.root = snvc
    }
    
    fileprivate func showLoading() {
        let loadingVC = Dependency.shared.resolver.resolve(LoadingViewController.self)!
        self.root = loadingVC
    }
    
    fileprivate func toggleLoading(isLoading: Bool) {
        isLoading ? showLoadingIndicator() : hideLoadingIndicator()
    }
    
    // #dev Handle localization with R.swift. A.H.
    @MainActor fileprivate func presentError(error: Error) {
        configureBanner(with: error.localizedDescription, color: .red)
    }
    
    fileprivate func showLoadingIndicator() {
        guard let vc = root?.topMostViewController() else {
            return
        }
        
        // Ensure the UI is updated from the main thread in case this method is called from a closure
        DispatchQueue.main.async {
            let indicator = UIActivityIndicatorView(style: .medium)
            indicator.center = CGPoint(x: vc.view.bounds.size.width/2, y: vc.view.bounds.size.height/2)
            indicator.startAnimating()
            vc.view.addSubview(indicator)
            
            self.activityIndicatorView = indicator
        }
    }
    
    fileprivate func hideLoadingIndicator() {
        guard let indicator = self.activityIndicatorView else {
            return
        }
        
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }

    @MainActor fileprivate func configureBanner(with text: String = "Thanks You", color: UIColor = .defaultTextColor) {
        // Setup view
        let view: MessageView = try! SwiftMessages.viewFromNib()
        
        // Add a drop shadow.
        view.configureDropShadow()
        
        // Theme message elements with the warning style.
        view.configureContent(body: text)
        view.configureTheme(backgroundColor: .white, foregroundColor: color)
        
        view.button?.isHidden = true
        view.titleLabel?.isHidden = true
                
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (view.backgroundView as? CornerRoundingView)?.layer.cornerRadius = 5.5
        
        // Add configurations
        var config = SwiftMessages.defaultConfig
        
        // Slide up from the top.
        config.presentationStyle = .top
        
        // Display in a window at the specified window level: UIWindow.Level.statusBar
        // displays over the status bar while UIWindow.Level.normal displays under.
        config.presentationContext = .window(windowLevel: UIWindow.Level(rawValue: UIWindow.Level.normal.rawValue))
        
        // Disable the default auto-hiding behavior with .forever
        config.duration = .seconds(seconds: TimingConstant.bannerDuration)
        
        // Dim the background like a popover view. Hide when the background is tapped.
         config.dimMode = .gray(interactive: true)
        
//         Disable the interactive pan-to-hide gesture.
         config.interactiveHide = true
        
        // Specify a status bar style to if the message is displayed directly under the status bar.
         config.preferredStatusBarStyle = .lightContent
        
        SwiftMessages.show(config: config, view: view)
    }
}
