//
//  Layout.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation

import UIKit

public final class Layout {
    private init() {}
    
    static var scaleFactor: CGFloat =  {
        let screenHeight = UIScreen.main.bounds.height
        let iPhone11DeviceScreenHeight: CGFloat = 896.0
        let scaleFactor = screenHeight / iPhone11DeviceScreenHeight
        return scaleFactor
    }()
        
    /// Returns scaled number based on device size
    /// - Parameter f: Source number
    static func scaled(_ source: CGFloat)-> CGFloat {
        return source * scaleFactor
    }
    
}
