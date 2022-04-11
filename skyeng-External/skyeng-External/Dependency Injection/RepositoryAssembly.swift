//
//  NetworkAssembly.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import Alamofire
import Swinject
import RealmSwift

final class RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(NetworkProviderConfigurable.self) { r in
            return NetworkProviderConfiguration()
        }
        
        // Singleton
        container.register(NetworkProviderType.self) { (r) in
            let networkProvider = NetworkAPIProvider(config: r.resolve(NetworkProviderConfigurable.self) as! NetworkProviderConfiguration,
                                                     adapter: r.resolve(RequestAdapter.self))
            networkProvider.coordinator = r.resolve(CoordinatorType.self)
            return networkProvider
            }
            .inObjectScope(.container)
        
        container.register(RepositoryType.self) { (r) in
            let repository = Repository(configuration: Realm.Configuration())
            return repository
            }
            .inObjectScope(.container)
    }
}
