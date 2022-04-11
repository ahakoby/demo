//
//  Image.swift
//  InAppStyle
//
//  Created by Armen Hakobyan on 16.02.22.
//

import UIKit

struct Image {
    static let logo:String = "SkyengNew"
}

extension UIImage{
    static func imageAsset(_ path:String, scheme:StyleScheme? = nil ) -> UIImage{
        let scheme = scheme ?? StyleScheme(rawValue: UserDefaults.standard.string(forKey: CurentSchemeKey)!)!
        let path = "\(scheme.rawValue)/images/\(path)"
        let resource = UIImage.init(named: path)
        if resource == nil{
            print("cant find image for \(path)")
            return  UIImage.init(color: .yellow)!
        }else{
            return resource!
        }
    }
}

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: CGSize.init(width: size.width/UIScreen.main.scale, height: size.height/UIScreen.main.scale))
         UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
         color.setFill()
         UIRectFill(rect)
         let image = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         
         guard let cgImage = image?.cgImage else { return nil }
         self.init(cgImage: cgImage)
    }
 }
