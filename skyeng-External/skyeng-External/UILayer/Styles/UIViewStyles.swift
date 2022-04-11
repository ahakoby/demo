//
//  UIViewStyles.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

/// An abstraction if `UIView` styling.
struct UIViewStyle<T: UIResponder> {
    
    /// The styling function that takes a `UIView` instance
    /// and performs side-effects on it.
    public let styling: (T) -> Void
    
    /// Apply this style to a UIView.
    ///
    /// - Parameter view: the view to style
    func apply(to view: T) {
        styling(view)
    }

}
