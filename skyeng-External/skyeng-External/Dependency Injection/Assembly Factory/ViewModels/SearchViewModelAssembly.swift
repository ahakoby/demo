//
//  GeneralViewModelAssembly.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
import Swinject

class SearchViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // MARK: Search
        container.register(SearchViewModelType.self) { resolver in
            let vm = SearchViewModel()
            vm.coordinator = resolver.resolve(CoordinatorType.self)
            return vm
        }

        // MARK: Result
        container.register(ResultViewModelType.self) { resolver in
            let onlineService = resolver.resolve(ResultUseCaseType.self,
                                                 name: AnyTranslateExecutable.online.rawValue)!
            let offlineService = resolver.resolve(ResultUseCaseType.self,
                                                  name: AnyTranslateExecutable.offline.rawValue)!
            
            let vm = ResultViewModel(resultUseCaseOnline: onlineService,
                                     resultUseCaseOffline: offlineService)

            vm.coordinator = resolver.resolve(CoordinatorType.self)
            return vm
        }

        // MARK: Detail
        container.register(DetailsViewModelType.self) { resolver in
            let vm = DetailsViewModel()
            return vm
        }

    }
    
}
