//
//  ResultUseCase.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 27.02.22.
//

import Foundation
import RxSwift

protocol ResultUseCaseType {
    func _meanings(ids: String) -> Single<Meanings>?
    func _search(text: String) -> Single<Words>
}

struct ResultUseCase: ResultUseCaseType, TranslateUseCase {
    var translateSwervice: TranslateServiceType

    func _meanings(ids: String) -> Single<Meanings>? {
        return meanings(ids)
    }

    func _search(text: String) -> Single<Words> {
        return search(text)
    }
}
