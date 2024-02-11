//
//  RxAlamofireResponse.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import RxSwift
import Alamofire
//import RxSwiftExt

extension DataRequest {
    func responseSingle<T: DecodableModel>(_ type: T.Type = T.self, queue: DispatchQueue? = nil, keyPath: String? = nil) -> Single<T>  {
        return Single<T>.create { (single) -> Disposable in
                let request = self.responseDecodableObject(queue: queue, keyPath: keyPath, decoder: jsonDecoder) { (response: DataResponse<T>) in
                    switch response.result {
                    case let .failure(err):
                        single(.error(err))
                    case let .success(val):
                        single(.success(val))
                    }
                }
                request.resume()
                return Disposables.create {
                    request.cancel()
                }
            }
            .asObservable()
            // in case of an error initial delay will be 0.2 second,
            // every next delay will be doubled
            // delay formula is: initial * pow(1 + multiplier, Double(currentAttempt - 1)), so multiplier 1.0 means, delay will doubled
            .retry(.exponentialDelayed(maxCount: 2, initial: 0.2, multiplier: 1.0), shouldRetry: { error in
                if let err = error as? SEError {
                    if case APIErrorReason.serverUnavailable = err.reason {
                        return true
                    }
                }

                return false
            })
            .asSingle()
    }
}
