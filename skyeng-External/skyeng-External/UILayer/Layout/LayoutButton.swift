//
//  LayoutButton.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import UIKit

public class LayoutButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        titleLabel?.font = titleLabel?.font.scaled()
    }
    
    @IBInspectable
    var localizableKey: String? {
        get { return nil }
        set(key) {
            setTitle(NSLocalizedString(key ?? "", comment: ""), for: .normal)
        }
    }
}
