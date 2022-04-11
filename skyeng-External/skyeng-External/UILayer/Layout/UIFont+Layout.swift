//
//  UIFont+Layout.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import UIKit

extension UIFont {
    /// Returns a new font scaled with scale factor
    ///
    /// - Parameter factor: Scel Factor
    /// - Returns: New font scaled with scale factor
    func scaling(with factor: CGFloat) -> UIFont  {
        let scaledPointSize = pointSize * factor
        return UIFont(name: fontName, size: scaledPointSize)!
    }
    
    /// Returns a new font scaled with default scale factor
    ///
    /// - Returns: New font scaled with default scale factor
    func scaled() -> UIFont {
        return scaling(with: Layout.scaleFactor)
    }
}
