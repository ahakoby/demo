//
//  GeneralViewModelAssembly.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
import Swinject

class LoadingViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // MARK: Loading
        container.register(LoadingViewModelType.self) { resolver in
            let vm = LoadingViewModel()
            vm.coordinator = resolver.resolve(CoordinatorType.self)
            return vm
        }
        
    }
    
}
