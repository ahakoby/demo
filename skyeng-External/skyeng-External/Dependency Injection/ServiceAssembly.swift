//
//  ServiceAssembly.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import Swinject

final class ServicesAssembly: Assembly {
    
    func assemble(container: Container) {

        container.register(TranslateOnlineServiceType.self) { r in
            return TranslateOnlineService(provider: r.resolve(NetworkProviderType.self)!)
            }.inObjectScope(.container)
        
        container.register(TranslateOfflineServiceType.self) { r in
            return TranslateOfflineService(repository: r.resolve(RepositoryType.self)!)
            }.inObjectScope(.container)
                
        container.register(ResultUseCaseType.self, name: AnyTranslateExecutable.online.rawValue) { r in
            return ResultUseCase(translateSwervice: AnyTranslateExecutable.online.make())
        }
        
        container.register(ResultUseCaseType.self, name: AnyTranslateExecutable.offline.rawValue) { r in
            return ResultUseCase(translateSwervice: AnyTranslateExecutable.offline.make())
        }
        
    }
    
}
