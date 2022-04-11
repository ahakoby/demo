//
//  GeneralViewControllersAssembly.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
import Swinject

class LoadingViewControllersAssembly: Assembly {
    
    func assemble(container: Container) {

        // MARK: Search
        container.register(LoadingViewController.self) { r in
            let vc = LoadingViewController.instanciated(inStoryboard: .Loading)
            vc.inject(viewModel: r.resolve(LoadingViewModelType.self)!)
            return vc
        }
        
    }
    
}
