//
//  HasErrorTracker.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import ObjectiveC
import UIKit

fileprivate var errorTrackerContext = "errorTracker"

protocol HasErrorTracker: AnyObject, AssociatedObjectStore {
    var errorTracker: ErrorTracker { get set }
}

extension HasErrorTracker {
    var errorTracker: ErrorTracker {
        get {
            return self.associatedObject(forKey: &errorTrackerContext, default: ErrorTracker())
        }
        set {
            self.setAssociatedObject(newValue, forKey: &errorTrackerContext)
        }
    }
}
