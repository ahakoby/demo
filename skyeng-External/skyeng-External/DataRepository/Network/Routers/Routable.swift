//
//  Routable.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import Alamofire

public enum ContentType: String {
    case json = "application/json"
    case formUrlencoded     = "application/x-www-form-urlencoded"
    case multipart = "multipart/form-data"
}

public protocol CoreDataConvertible {
    var entitiName: String? {get}
}


protocol Routable: URLRequestConvertible, URLConvertible, CoreDataConvertible {
    var isAbsolute: String? { get }
    var baseURLString: String { get }
    var method: HTTPMethod { get }
    var pathPrefix: String { get }
    var path: String? { get }
    var responseRootKey: String? { get }
    var encoder: ParameterEncoding { get }
    var params: Parameters? { get }
    var headers: [String: String]? { get }
    var contentType: ContentType { get }
    var file: Data? { get }
    var requiresAuthentication: Bool { get }
    var nestedParams: [[String: Any]]? { get }
}

extension Routable {
    var nestedParams: [[String: Any]]? {
        return nil
    }
}


extension Routable {
    var isAbsolute: String? {
        return nil
    }
    
    var baseURLString: String {
        return AppEnvironment.current.baseURL
    }
    
    var pathPrefix: String {
        return ""
    }
    
    var path: String? {
        return nil
    }
    
    var encoder: ParameterEncoding {
        if method == .get {
            return URLEncoding.default
        } else {
            return JSONEncoding.default
        }
    }
    
    var responseRootKey: String? {
        return nil
    }
    
    var params: Parameters? {
        return nil
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var requiresAuthentication: Bool {
        return true
    }
    
    var contentType: ContentType {
        return .json
    }
    
    var file: Data? {
        return nil
    }
    
    func asURL() throws -> URL {
        let url = try self.baseURLString.asURL()
        var urlString = url.absoluteString
        
        if let absoluteURl = self.isAbsolute {
            urlString = absoluteURl
        }
        else {
            if !pathPrefix.isEmpty { urlString += "/\(pathPrefix)" }
            if let path = self.path {
                urlString += "/\(path)"
            }
            
            guard let urlstr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                throw SEError.error(withReason: .invalidURL(url: urlString))
            }
            urlString = urlstr
        }
        guard let validURL = URL(string: urlString) else {
            throw SEError.error(withReason: .invalidURL(url: urlString))
        }
        return validURL
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        
        // NOTE: Not cool, but a fix for 'Paramreters' nested array data type issue
        if let params = self.nestedParams {
            urlRequest.httpBody =  try JSONSerialization.data(withJSONObject: params)
        } else {
            urlRequest = try self.encoder.encode(urlRequest, with: self.params)
        }
        
        var headers = defaultHTTPHeaders()
        if let customHeaders = self.headers {
            headers.merge(customHeaders, uniquingKeysWith: { $1 })
        }
        urlRequest.allHTTPHeaderFields = headers
        
        return urlRequest
    }
    
    private func defaultHTTPHeaders() -> [String: String] {
        var headers = [String: String]()
        headers["Content-Type"] = self.contentType.rawValue
        return headers
    }
}

