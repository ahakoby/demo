//
//  Color.swift
//  InAppStyle
//
//  Created by Armen Hakobyan on 16.02.22.
//

import UIKit

enum StyleColor: String{
    case
    defaultBG = "colors/BG",
    defaultText = "colors/Text"
}

extension UIColor {
    static var defaultTextColor: UIColor {
        return .colorAsset(.defaultText,
                           scheme: nil)
    }
}

extension UIColor {
    static func colorAsset(_ color:StyleColor, scheme:StyleScheme? = nil ) -> UIColor {
        let scheme = scheme ?? StyleScheme(rawValue: UserDefaults.standard.string(forKey: CurentSchemeKey)!)!
        let path = "\(scheme.rawValue)/\(color.rawValue)"
        let resource = UIColor.init(named: path)
         if resource == nil{
             print("cant find color for \(path)")
             return .red
         }else{
             return resource!
         }
    }
}


