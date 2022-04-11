//
//  LayoutConstraint.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import UIKit

@IBDesignable
public class LayoutConstraint: NSLayoutConstraint {
    
    @IBInspectable
    var maximumConstant: CGFloat = 0.0

    @IBInspectable
    var relativeConstant: CGFloat = 0.0 {
        didSet {
            var expectedConstant = relativeConstant * Layout.scaleFactor
            if maximumConstant != 0 {
                expectedConstant = min(expectedConstant, maximumConstant)
            }
            constant = round(expectedConstant)
        }
    }
    
}
