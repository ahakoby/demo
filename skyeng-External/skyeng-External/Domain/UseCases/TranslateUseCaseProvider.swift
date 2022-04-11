//
//  Translate.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 27.02.22.
//

import Foundation
import RxSwift

protocol TranslateUseCase {
    var translateSwervice: TranslateServiceType {get}
}

extension TranslateUseCase {
    func meanings(_ ids: String) -> Single<Meanings>? {
        return translateSwervice.meanings(ids: ids)
    }
    
    func search(_ text: String) -> Single<Words> {
        return translateSwervice.search(text: text)
    }
}
