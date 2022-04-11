//
//  ResultViewModel.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ResultViewModelInputs {
    func search(_ text: String)
    func translateItemClicked(item: Word, word: String)
}

protocol ResultViewModelOutputs {
    var translateDriver: Driver<[TranslationSection]> { get }
}

protocol ResultViewModelType: ViewModelType {
    var inputs: ResultViewModelInputs { get }
    var outputs: ResultViewModelOutputs { get }
}

final class ResultViewModel: BaseViewModel,
                                            ResultViewModelInputs,
                                            ResultViewModelOutputs,
                                            ResultViewModelType {

    // MARK: - ProfileViewModelType
    var inputs: ResultViewModelInputs { return self }
    var outputs: ResultViewModelOutputs { return self }

    // MARK: - Public Params
    var coordinator: CoordinatorType?

    private var resultUseCaseOnline: ResultUseCaseType
    private var resultUseCaseOffline: ResultUseCaseType
    
    private var searchingText = ""

    // MARK: - Initializers
    init(resultUseCaseOnline: ResultUseCaseType, resultUseCaseOffline: ResultUseCaseType) {
        self.resultUseCaseOnline = resultUseCaseOnline
        self.resultUseCaseOffline = resultUseCaseOffline

        super.init()
    }

    // MARK: - Inputs
    func search(_ text: String) {
        if searchingText == text {return}
        searchingText = text
        translateRealay.accept([])        
        resultUseCaseOnline._search(text: text)
            .trackActivity(self.activityIndicator)
            .trackError(self.errorTracker)
            .subscribe(onNext: { [weak self] words in
                guard let strongSelf = self else { return }
                strongSelf.translateRealay.accept(strongSelf.convertTranslateSections(words))
            }, onError: { [weak self] error in
                guard let strongSelf = self else { return }
                strongSelf.localSearch(text)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func localSearch(_ text: String) {
        resultUseCaseOffline._search(text: text)
            .trackActivity(self.activityIndicator)
            .trackError(self.errorTracker)
            .subscribe(onNext: { [weak self] words in
                guard let strongSelf = self else { return }
                strongSelf.translateRealay.accept(strongSelf.convertTranslateSections(words))
            })
            .disposed(by: self.disposeBag)

    }

    func translateItemClicked(item: Word, word: String) {
        coordinator?.execute(step: SearchStep.detail(model: item, word: word))
    }

    // MARK: - outputs
    private let translateRealay = BehaviorRelay<[TranslationSection]>(value: [])
    lazy var translateDriver: Driver<[TranslationSection]> = {
        return translateRealay.asDriver()
    }()

    //MARK: - helper
    private func convertTranslateSections(_ translates: Words) -> [TranslationSection] {
        return [TranslationSection(items: translates.items ?? [])]
    }
}
