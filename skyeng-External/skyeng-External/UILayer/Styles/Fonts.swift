//
//  Fonts.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import UIKit

struct Font {
    static func sfProDisplayRegular(_ size:CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProDisplay-Regular", size: size*Layout.scaleFactor) else {
            return UIFont.systemFont(ofSize: size*Layout.scaleFactor, weight: .bold)
        }
        
        return font
    }
    
    static func sfProDisplayBold(_ size:CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProDisplay-Bold", size: size*Layout.scaleFactor) else {
            return UIFont.systemFont(ofSize: size*Layout.scaleFactor, weight: .bold)
        }
        
        return font
    }

    static func sfProDisplayHeavy(_ size:CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProDisplay-Heavy", size: size*Layout.scaleFactor) else {
            return UIFont.systemFont(ofSize: size*Layout.scaleFactor, weight: .bold)
        }
        
        return font
    }
    
    static func sfProDisplaySemiBold(_ size:CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProDisplay-Semibold", size: size*Layout.scaleFactor) else {
            return UIFont.systemFont(ofSize: size*Layout.scaleFactor, weight: .bold)
        }
        
        return font
    }
   
    static func sfProDisplayMedium(_ size:CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProDisplay-Medium", size: size*Layout.scaleFactor) else {
            return UIFont.systemFont(ofSize: size*Layout.scaleFactor, weight: .bold)
        }
        
        return font
    }
    
    static func gilroyMedium(_ size:CGFloat) -> UIFont {
        guard let font = UIFont(name: "Gilroy-Medium", size: size*Layout.scaleFactor) else {
            return UIFont.systemFont(ofSize: size*Layout.scaleFactor, weight: .bold)
        }
        
        return font
    }
    
    static func gilroyBold(_ size:CGFloat) -> UIFont {
        guard let font = UIFont(name: "Gilroy-Bold", size: size*Layout.scaleFactor) else {
            return UIFont.systemFont(ofSize: size*Layout.scaleFactor, weight: .bold)
        }
        
        return font
    }
    
    static func gilroySemiBold(_ size:CGFloat) -> UIFont {
        guard let font = UIFont(name: "Gilroy-SemiBold", size: size*Layout.scaleFactor) else {
            return UIFont.systemFont(ofSize: size*Layout.scaleFactor, weight: .bold)
        }
        
        return font
    }
}
