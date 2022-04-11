//
//  Dependency.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
import Swinject

final class Dependency {
    
    private var assembler: Assembler!
    
    var resolver: Resolver {
        return assembler.resolver
    }
    
    static var shared: Dependency = {
        return Dependency()
    }()
    
    private init() { }
    
    func initialize() {
        self.assembler = Assembler([
                                    // View Models
                                    LoadingViewModelAssembly(),
                                    SearchViewModelAssembly(),
                                    // View Controllers
                                    LoadingViewControllersAssembly(),
                                    SearchViewControllersAssembly(),
                                    // Others
                                    ServicesAssembly(),
                                    RepositoryAssembly(),
                                    OtherAssembly()
                                    ])
    }
}
