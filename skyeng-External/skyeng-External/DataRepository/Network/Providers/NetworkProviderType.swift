//
//  NetworkProviderType.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import Alamofire
import RxSwift

protocol NetworkProviderType {
    // RxSwift
    func createResponseSingle<T: DecodableModel, R: Routable>(route: R) -> Single<T>
}
