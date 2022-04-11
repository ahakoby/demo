//
//  HasActivityIndicator.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import ObjectiveC
import UIKit

fileprivate var activityIndicatorKey = "activityIndicator"

protocol HasActivityIndicator: AnyObject, AssociatedObjectStore {
    var activityIndicator: ActivityIndicator { get set }
}

extension HasActivityIndicator {
    var activityIndicator: ActivityIndicator {
        get {
            return self.associatedObject(forKey: &activityIndicatorKey, default: ActivityIndicator())
        }
        set {
            self.setAssociatedObject(newValue, forKey: &activityIndicatorKey)
        }
    }
}
