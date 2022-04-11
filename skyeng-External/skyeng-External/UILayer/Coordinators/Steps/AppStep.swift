//
//  AppStep.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation

enum AppStep: CoordinatorStepType {
    case loading
    case search
    
    case toggleLoading(Bool)
    case presentError(Error)
}
