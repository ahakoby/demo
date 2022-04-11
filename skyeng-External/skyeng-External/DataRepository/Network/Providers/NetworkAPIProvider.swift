//
//  NetworkAPIProvider.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkAPIProvider: NetworkProviderType {
    
    var sessionManager: SessionManager? = nil
    var authenticationAdapter: RequestAdapter?
    var coordinator: CoordinatorType?
    
    init(config: NetworkProviderConfiguration) {
        sessionManager = SessionManager(configuration: config.sessionConfig)
        sessionManager?.startRequestsImmediately = false
    }
    
    convenience init(config: NetworkProviderConfiguration, adapter: RequestAdapter?) {
        self.init(config: config)
        authenticationAdapter = adapter
    }
    
    
    func createResponseSingle<T, R>(route: R) -> PrimitiveSequence<SingleTrait, T> where T : DecodableModel, R : Routable {
        guard let sessionManager = self.sessionManager else {
            return Single.error(SEError.error(withReason: .sessionUnavailable))
        }

        return sessionManager
            .request(route)
            .responseSingle(keyPath: route.responseRootKey)
    }
}

