//
//  NetworkProviderConfiguration.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import Alamofire

protocol NetworkProviderConfigurable: ProviderConfigurable {
    var sessionConfig: URLSessionConfiguration { get set }
    
    init(sessionConfiguration: URLSessionConfiguration)
}

struct NetworkProviderConfiguration: NetworkProviderConfigurable {
    var sessionConfig: URLSessionConfiguration
    
    /// Provides an initializer and default values for the required properties.
    init(sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.sessionConfig = sessionConfiguration
    }
}
