//
//  String+Extension.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 12.01.22.
//

import Foundation

extension String {
        
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
    func replaceAllChars(with char: String) -> String {
        var result = ""
        for _ in self {
            result += char
        }
        return result
    }
    
    var nilIfEmpty: String? {
        return self.isEmpty ? nil : self
    }
    
    func toUrl() -> URL? {
        let url = URL(string: self.replacingOccurrences(of: " ", with: "%20"))
        return url
    }
}
