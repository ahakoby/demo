//
//  ViewModelType.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
protocol ViewModelType: HasActivityIndicator, HasErrorTracker, HasDisposeBag {
    var coordinator: CoordinatorType? { get }
    func bindActivityIndicator()
    func bindErrorTracker()
}

extension ViewModelType {
    var coordinator: CoordinatorType? {
        return Dependency.shared.resolver.resolve(CoordinatorType.self)
    }
}

extension ViewModelType {
    func bindActivityIndicator() {
        self.activityIndicator
            .asDriver()
            .drive(onNext: { [weak self] (loading) in
                self?.coordinator?.execute(step: AppStep.toggleLoading(loading))
            })
            .disposed(by: disposeBag)
    }
}

extension ViewModelType {
    func bindErrorTracker() {
        self.errorTracker
            .asDriver()
            .drive(onNext: { [weak self] (error) in
                self?.coordinator?.execute(step: AppStep.presentError(error))
            })
            .disposed(by: self.disposeBag)
    }
}
