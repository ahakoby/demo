//
//  SearchCoordinator.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import UIKit

final class SearchCoordinator: CoordinatorType, CoordinatorDelegate {
    
    weak var delegate: CoordinatorDelegate?

    weak var navigationController: BaseNavigationController?
    var childCoordinators: [CoordinatorType] = []
    
    private var window: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    init(navigationController: BaseNavigationController, delegate: CoordinatorDelegate? = nil) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    @discardableResult func execute(step: CoordinatorStepType) -> Bool {
        guard let rootStep = step as? SearchStep else {
            return self.cascade(step: step)
        }
        
        switch rootStep {
        case .result(let text)                :showResult(with: text)
        case .detail(let model, let word)     :showDetail(with: model, word: word)
        case .backToRoot                      :back(toRoot: true)
        case .back                            :back(toRoot: false)
        case .close                           :close()
        }
        
        return true
    }
    

    fileprivate func showResult(with text: String?) {
        let resultVC = Dependency.shared.resolver.resolve(ResultViewController.self)!
        resultVC.configure(with: text)
        self.navigationController?.pushViewController(resultVC, animated: true)

    }
        
    fileprivate func showDetail(with model: Word, word: String) {
        let detailVC = Dependency.shared.resolver.resolve(DetailsViewController.self)!
        detailVC.configure(with: model, word: word)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    fileprivate func back(toRoot: Bool) {
        if toRoot == true {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    fileprivate func close() {
        self.delegate?.coordinatorFinishedFlow(coordinator: self)
    }
}
