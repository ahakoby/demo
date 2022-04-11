//
//  TranslateRouter.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import Alamofire

enum TranslateRouter: Routable {
    case meanings(ids: String)
    case search(text: String)
    
    var path: String? {
        switch self {
        case .meanings:
            return ""
//            return "api/public/v1/meanings"
        case .search:
//            return ""
            return "api/public/v1/words/search"

        }
    }
    
    var method: HTTPMethod {
        switch  self {
        case .meanings, .search:
            return .get
        }
    }
    
    var contentType: ContentType {
        switch self {
        case .meanings, .search:
            return .json
        }
    }
    
    var params: Parameters? {
        switch self {
        case .meanings(let ids):
            return ["ids": ids]
        case .search(let text):
            return ["search": text]
        }
    }
    
    var entitiName: String? {
        switch self {
        case .meanings:
            return "Meaning"
        case .search:
            return "Words"
        }
    }
}

