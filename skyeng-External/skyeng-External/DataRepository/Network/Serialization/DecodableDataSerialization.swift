//
//  DecodableDataSerialization.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import Alamofire

extension DataRequest {
    private static func DecodableObjectSerializer<T: Decodable>(_ keyPath: String?, _ decoder: JSONDecoder) -> DataResponseSerializer<T> {
        return DataResponseSerializer { request, response, data, error in
            Log.network("[REQUEST] \(request?.url?.absoluteString ?? "")")
            if let bytes = data,
                let responseBody = String(data: bytes, encoding: .utf8) {
                Log.network("[RESPONSE] \(responseBody)")
            }
            if let error = error {
                Log.network("[ERROR] \(error)")
                return .failure(error)
            }
            
            if let statusCode = response?.statusCode, statusCode > 299 {
                let apierrorResult: Result<APIError> = DataRequest.decodeToObject(decoder: decoder, response: response, data: data)
                switch apierrorResult {
                case let .success(apierror):
                    return .failure(apierror)
                case let .failure(err):
                    return .failure(err)
                }
            }
            
            if let keyPath = keyPath {
                if keyPath.isEmpty {
                    return .failure(MappingError.error(withReason: .valueNotFound(forKey: keyPath)))
                }
                return DataRequest.decodeToObject(byKeyPath: keyPath, decoder: decoder, response: response, data: data)
            }
            return DataRequest.decodeToObject(decoder: decoder, response: response, data: data)
        }
    }

    private static func decodeToObject<T: Decodable>(decoder: JSONDecoder, response: HTTPURLResponse?, data: Data?) -> Result<T> {
        let result = Request.serializeResponseData(response: response, data: data, error: nil)
        switch result {
        case .success(let data):
            do {
                let object = try decoder.decode(T.self, from: data)
                return .success(object)
            }
            catch {
                return .failure(error)
            }
        case .failure(let error): return .failure(error)
        }
    }
    
    private static func decodeToObject<T: Decodable>(byKeyPath keyPath: String, decoder: JSONDecoder, response: HTTPURLResponse?, data: Data?) -> Result<T> {
        let result = Request.serializeResponseJSON(options: [], response: response, data: data, error: nil)
        switch result {
        case .success(let json):
            if let nestedJson = (json as AnyObject).value(forKeyPath: keyPath) {
                do {
                    let data = try JSONSerialization.data(withJSONObject: nestedJson)
                    let object = try decoder.decode(T.self, from: data)
                    return .success(object)
                }
                catch {
                    
                    return .failure(error)
                }
            }
            else {
                return .failure(MappingError.error(withReason: .valueNotFound(forKey: keyPath)))
            }
        case .failure(let error): return .failure(error)
        }
    }
    
    /// Adds a handler to be called once the request has finished.
    
    /// - parameter queue:             The queue on which the completion handler is dispatched.
    /// - parameter keyPath:           The keyPath where object decoding should be performed. Default: `nil`.
    /// - parameter decoder:           The decoder that performs the decoding of JSON into semantic `Decodable` type. Default: `JSONDecoder()`.
    /// - parameter completionHandler: The code to be executed once the request has finished and the data has been mapped by `JSONDecoder`.
    
    /// - returns: The request.
    @discardableResult
    func responseDecodableObject<T: Decodable>(queue: DispatchQueue? = nil, keyPath: String? = nil, decoder: JSONDecoder = jsonDecoder, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataRequest.DecodableObjectSerializer(keyPath, decoder), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseDecodableSequence<D: Decodable>(queue: DispatchQueue? = nil, keyPath: String? = nil, decoder: JSONDecoder = jsonDecoder, completionHandler: @escaping (DataResponse<[D]>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataRequest.DecodableObjectSerializer(keyPath, decoder), completionHandler: completionHandler)
    }
}
