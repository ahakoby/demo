//
//  LoadingViewModel.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoadingViewModelInputs {
    func viewDidLoad()
}

protocol LoadingViewModelOutputs {
    
}

protocol LoadingViewModelType: ViewModelType {
    var inputs: LoadingViewModelInputs { get }
    var outputs: LoadingViewModelOutputs { get }
}

final class LoadingViewModel: BaseViewModel,
                                            LoadingViewModelInputs,
                                            LoadingViewModelOutputs,
                                            LoadingViewModelType {

    // MARK: - ProfileViewModelType
    var inputs: LoadingViewModelInputs { return self }
    var outputs: LoadingViewModelOutputs { return self }
    
    // MARK: - Public Params
    var coordinator: CoordinatorType?

    // MARK: - Initializers
    override init() {
        
    }
    
    // MARK: - Inputs
    func viewDidLoad() {
        self.coordinator?.execute(step: AppStep.search)
    }
    // MARK: - outputs
}
