//
//  Style.swift
//  InAppStyle
//
//  Created by Armen Hakobyan on 16.02.22.
//

import UIKit

let CurentSchemeKey = "CurentScheme"

enum StyleScheme: String{
    case
    dark,
    light,
    unspecified
}

extension UIUserInterfaceStyle {
    var scheme: StyleScheme {
        get {
            switch self {
            case .unspecified:
                UserDefaults.standard.set(StyleScheme.unspecified.rawValue, forKey: CurentSchemeKey)
                return .unspecified
            case .light:
                UserDefaults.standard.set(StyleScheme.light.rawValue, forKey: CurentSchemeKey)
                return .light
            case .dark:
                UserDefaults.standard.set(StyleScheme.dark.rawValue, forKey: CurentSchemeKey)
                return .dark
            @unknown default:
                UserDefaults.standard.set(StyleScheme.unspecified.rawValue, forKey: CurentSchemeKey)
                return .unspecified
            }
        }
    }
}
