//
//  UIImageView+Extension.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 16.01.22.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    static let placeholderImage = UIImage(named: "")
    
    func setImage(_ url: URL?,
                  style: UIActivityIndicatorView.Style = .gray,
                  placeholder: UIImage? = UIImageView.placeholderImage,
                  completion: ((UIImage?) -> Void)? = nil) {
        
        self.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached) { (image, _, _, _) in
            completion?(image)
        }
    }
}
