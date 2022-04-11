//
//  SearchStep.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation

enum SearchStep: CoordinatorStepType {
    case result(text: String?)
    case detail(model: Word, word: String)
    case back
    case backToRoot
    case close
}
