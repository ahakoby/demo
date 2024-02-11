//
//  AppDelegate.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import UIKit
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    private func configureLunchScenePoint() {
        // #dev looks bad but works :) A.H.
        self.appCoordinator = Dependency.shared.resolver.resolve(CoordinatorType.self) as? AppCoordinator
        self.appCoordinator.execute(step: AppStep.loading)
            
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window

        Dependency.shared.initialize()
        AppEnvironment.setup()
        AppEnvironment.log()
        configureLunchScenePoint()
                        
        return true
    }

}
