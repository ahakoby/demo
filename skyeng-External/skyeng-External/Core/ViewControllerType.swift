//
//  ViewControllerType.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation

protocol ViewControllerType {
    associatedtype VMType: ViewModelType
    var viewModel: VMType { get }
    init(viewModel: VMType)
}
