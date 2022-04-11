//
//  BaseStyles.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import UIKit

struct BaseStyles {
    
    static let defaultBackgroundView: UIViewStyle<UIView> = UIViewStyle { view in
        view.backgroundColor = .colorAsset(.defaultBG,
                                           scheme: view.traitCollection.userInterfaceStyle.scheme)
    }

}


