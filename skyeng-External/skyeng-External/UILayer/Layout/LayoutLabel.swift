//
//  LayoutLabel.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import UIKit

public class LayoutLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        font = font.scaled()
    }
    
    @IBInspectable
    var localizableKey: String? {
        get { return nil }
        set(key) {
            text = NSLocalizedString(key ?? "", comment: "")
        }
    }
}
