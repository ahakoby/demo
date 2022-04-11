//
//  HasDisposBug.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import RxSwift

fileprivate var disposeBagKey = "disposeBagKey"

protocol HasDisposeBag: AnyObject, AssociatedObjectStore {
    var disposeBag: DisposeBag { get }
}

extension HasDisposeBag {
    var disposeBag: DisposeBag {
        get {
            return self.associatedObject(forKey: &disposeBagKey, default: DisposeBag())
        }
        set {
            self.setAssociatedObject(newValue, forKey: &disposeBagKey)
        }
    }
}
