//
//  CoordinatorType.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
import Foundation
import RxSwift

protocol CoordinatorDelegate: AnyObject {
    func coordinatorFinishedFlow(coordinator: CoordinatorType)
    func coordinatorExecuteStep(step: CoordinatorStepType)
}

/// Marker protocol for normal steps
protocol CoordinatorStepType { }

/// Marker protocol for observable steps
protocol ObservableCoordinatorStepType {
    associatedtype Result
}

protocol CoordinatorType: HasDisposeBag {
    
    /// Array of child coordinators that were initiated by this coordinator
    var childCoordinators: [CoordinatorType] { get set }
    
    /// Delegate to notify parent that coordinator finished
    var delegate: CoordinatorDelegate? { get set }
    
    /// Executes a coordination step on a specific child coordinator
    func execute(step: CoordinatorStepType, onChild coordinator: CoordinatorType) -> Bool
    
    /// Passes the step to all the child coordinators
    func cascade(step: CoordinatorStepType) -> Bool
    func cascade<Step: ObservableCoordinatorStepType>(step: Step) -> Observable<Step.Result?>
    
    /// Adds a coordinator to the child
    func add(childCoordinator coordinator: CoordinatorType)
    
    func remove(childCoordinator coordinator: CoordinatorType)
    
    /// Tries to handle a navigation step, if it can handle it, returns true. False otherwise.
    @discardableResult
    func execute(step: CoordinatorStepType) -> Bool
    func execute<Step: ObservableCoordinatorStepType>(step: Step) -> Observable<Step.Result?>
}

extension CoordinatorType where Self: CoordinatorDelegate {
    func add(childCoordinator coordinator: CoordinatorType) {
        self.childCoordinators.append(coordinator)
        coordinator.delegate = self
    }
    
    func remove(childCoordinator coordinator: CoordinatorType) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
    }
}


extension CoordinatorType {
    func execute<Step, Result>(step: Step) -> Observable<Result?> where Step: ObservableCoordinatorStepType, Step.Result == Result {
        return self.cascade(step: step)
    }
    
    var delegate: CoordinatorDelegate? {
        return nil
    }
    
    func execute(step: CoordinatorStepType, onChild coordinator: CoordinatorType) -> Bool {
        return coordinator.execute(step: step)
    }
    
    func execute<Step, Result>(step: Step,
                               onChild coordinator: CoordinatorType) -> Observable<Result?>
    where Step: ObservableCoordinatorStepType, Step.Result == Result {
        return coordinator.execute(step: step)
    }
    
    func cascade(step: CoordinatorStepType) -> Bool {
        let childExecuted = childCoordinators.compactMap { child -> Bool? in
            return self.execute(step: step, onChild: child)
            }
            .map { $0! }
            .reduce(true, { $0 && $1 })
        
        return childExecuted
    }
    
    func cascade<Step, Result>(step: Step) -> Observable<Result?>
    where Step: ObservableCoordinatorStepType, Step.Result == Result {
        let childExecuted = childCoordinators.map { child -> Observable<Result?> in
            return self.execute(step: step, onChild: child)
        }
        return Observable.merge(childExecuted)
    }
}

extension CoordinatorDelegate where Self: CoordinatorType {
    func coordinatorFinishedFlow(coordinator: CoordinatorType) {
        self.remove(childCoordinator: coordinator)
    }
    
    func coordinatorExecuteStep(step: CoordinatorStepType) {
        self.execute(step: step)
    }
}
