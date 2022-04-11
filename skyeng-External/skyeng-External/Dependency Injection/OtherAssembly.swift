//
//  OtherAssembly.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
import Swinject

class OtherAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(CoordinatorType.self) { (_) in
            return AppCoordinator()
            }.inObjectScope(.container)
        
    }
        
}
