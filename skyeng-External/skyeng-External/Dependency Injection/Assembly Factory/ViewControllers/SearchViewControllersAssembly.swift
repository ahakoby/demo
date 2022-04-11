//
//  GeneralViewControllersAssembly.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
import Swinject

class SearchViewControllersAssembly: Assembly {
    
    func assemble(container: Container) {

        // MARK: Search
        container.register(SearchViewController.self) { r in
            let vc = SearchViewController.instanciated(inStoryboard: .Search)
            vc.inject(viewModel: r.resolve(SearchViewModelType.self)!)
            return vc
        }
        
        // MARK: Result
        container.register(ResultViewController.self) { r in
            let vc = ResultViewController.instanciated(inStoryboard: .Search)
            vc.inject(viewModel: r.resolve(ResultViewModelType.self)!)
            return vc
        }
        
        // MARK: Detail
        container.register(DetailsViewController.self) { r in
            let vc = DetailsViewController.instanciated(inStoryboard: .Search)
            vc.inject(viewModel: r.resolve(DetailsViewModelType.self)!)
            return vc
        }

    }
    
}
