//
//  SearchViewModel.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SearchViewModelInputs {
    func searchBarShouldBeginEditing()
    func searchBarSearchButtonClicked(text: String)
}

protocol SearchViewModelOutputs {}

protocol SearchViewModelType: ViewModelType {
    var inputs: SearchViewModelInputs { get }
    var outputs: SearchViewModelOutputs { get }
}

final class SearchViewModel: BaseViewModel,
                                            SearchViewModelInputs,
                                            SearchViewModelOutputs,
                                            SearchViewModelType {

    // MARK: - ProfileViewModelType
    var inputs: SearchViewModelInputs { return self }
    var outputs: SearchViewModelOutputs { return self }
    
    // MARK: - Public Params
    var coordinator: CoordinatorType?

    // MARK: - Initializers
    override init() {}
    
    // MARK: - Inputs
    func searchBarShouldBeginEditing() {
        self.coordinator?.execute(step: SearchStep.result(text: nil))
    }
    
    func searchBarSearchButtonClicked(text: String) {
        self.coordinator?.execute(step: SearchStep.result(text: text))
    }
}
