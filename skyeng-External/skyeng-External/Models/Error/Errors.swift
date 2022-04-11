//
//  Errors.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation

protocol ErrorReasonType {}

protocol ErrorType: Swift.Error {
    associatedtype ReasonType: ErrorReasonType

    var formattedError: String { get }
    var reason: ReasonType { get }

    static func error(withReason reason: ReasonType) -> Self
    init(reason: ReasonType)
}

extension ErrorType {
    var localizedDescription: String {
        return formattedError
    }

    static func error(withReason reason: ReasonType) -> Self {
        return self.init(reason: reason)
    }
}

enum APIErrorCode: String {
    // Generic
    case unknown = "error.unknown"
    case request_invalid = "request.invalid"
    case internal_server = "error.internal_server"
    case forbidden = "error.forbidden"
}

extension APIErrorCode {
    init() {
        self = .unknown
    }

    init?(_ value: String) {
        switch value.lowercased() {
        case "error.unknown": self = .unknown
        case "request.invalid": self = .request_invalid
        case "error.internal_server": self = .internal_server
        case "error.forbidden": self = .forbidden

        default: return nil
        }
    }

    func toLocalizableString() -> String {
        return self.rawValue.localized()
    }
}

enum APIError: LocalizedError, DecodableModel {
    case general(status: String, code: APIErrorCode, message: String, description: String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let response = try container.decode(APIErrorResponse.self)

        guard let errors = response.errors, errors.count > 0 else {
            throw MappingError(reason: .valueNotFound(forKey: "errors"))
        }

        guard let status = response.status else {
            throw MappingError(reason: .valueNotFound(forKey: "status"))
        }

        let codes = errors.map { error -> APIErrorCode in
            guard let code = error.code else {
                return .unknown
            }

            return APIErrorCode(rawValue: code) ?? .unknown
        }

        let descriptions = errors.map { error -> String in
            if let description = error.description {
                return description
            }

            return "Error description is empty"
        }

        self = .general(status: "\(status)", code: codes.first ?? .unknown,
                        message: "userMessage", description: descriptions.joined(separator: "\n"))
    }

    var errorDescription: String? {
        return self.localizedDescription
    }

    var localizedDescription: String {
        switch self {
        case let .general(_, code, _, _):
            return code.toLocalizableString()
        }
    }
}

struct APIErrorResponse: DecodableModel {
    let status: Int?
    let code: String?
    let path: String?
    let timestamp: String?
    let errors: [APISingleError]?

    private enum CodingKeys: String, CodingKey {
        case status, code, path, timestamp, errors
    }
    
    static func ==(lhs: APIErrorResponse, rhs: APIErrorResponse) -> Bool {
        return lhs.status == rhs.status
    }
}

struct APISingleError: DecodableModel {
    let code: String?
    let userMessage: String?
    let description: String?

    private enum CodingKeys: String, CodingKey {
        case code, userMessage, description
    }
}

enum APIErrorReason: ErrorReasonType {
    case serverUnavailable
    case sessionUnavailable
    case invalidURL(url: String)
    case general
}

struct SEError: ErrorType, LocalizedError {
    let reason: APIErrorReason
    var formattedError: String {
        switch reason {
        case .general:
            return "Unknown error"
        case let .invalidURL(url):
            return "Invalid URL: \(url)"
        case .sessionUnavailable:
            return "Session not available"
        case .serverUnavailable:
            return "Something went wrong when connecting to the server"

        }
    }
    
    var errorDescription: String? {
        return self.localizedDescription
    }
    
    var localizedDescription: String {
        switch reason {
        case .general:
            return "Unknown error"
        case let .invalidURL(url):
            return "Invalid URL: \(url)"
        case .sessionUnavailable:
            return "Session not available"
        case .serverUnavailable:
            return "Something went wrong when connecting to the server"

        }
    }
}

struct MappingError: ErrorType, LocalizedError {
    let reason: MappingErrorReason
    
    var formattedError: String {
        switch reason {
        case let .keyNotFound(key):
            return "Key not found: \(key)"
        case let .valueNotFound(forKey):
            return "Value not found for key: \(forKey)"
        }
    }
    
    var errorDescription: String? {
        switch reason {
        case let .keyNotFound(key):
            return "Key not found: \(key)"
        case let .valueNotFound(forKey):
            return "Value not found for key: \(forKey)"
        }
    }
}

enum MappingErrorReason: ErrorReasonType {
    case keyNotFound(key: String)
    case valueNotFound(forKey: String)
}



struct RmError: LocalizedError {
    let reason: RmErrorReason
        
    var errorDescription: String? {
        switch reason {
        case let .entityNotFound(key):
            return "\(key) is not found in local storage"
        }
    }
}

enum RmErrorReason: ErrorReasonType {
    case entityNotFound(key: String)
}

enum InnerError: LocalizedError {
    
    case wrongInit
    case noParam
    
    var localizedDescription: String {
        switch self {
        case .wrongInit:
            return "init has not been implemented"
        case .noParam:
            return "parameter does not exist"
        }
    }
    
    var errorDescription: String? {
        return self.localizedDescription
    }
    
}


