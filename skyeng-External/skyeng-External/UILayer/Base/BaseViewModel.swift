//
//  BaseViewModel.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
import RxCocoa
import RxSwift

class BaseViewModel: ViewModelType, ReactiveCompatible {
    
    init() {
        Log.initOf(self)
    }
    
    deinit {
        Log.deinitOf(self)
    }
}
