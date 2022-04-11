//
//  TranslateSection.swift
//  Assistante
//
//  Created by Armen Hakobyan on 15.01.22.
//

import Foundation
import RxDataSources

struct TranslationSection {
    var items: [Item]
}

extension TranslationSection: SectionModelType {
    typealias Item = Word
    
    init(original: TranslationSection, items: [Item]) {
        self = original
        self.items = items
    }
}
