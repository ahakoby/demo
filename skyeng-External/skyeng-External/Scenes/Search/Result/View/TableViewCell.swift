//
//  TableViewCell.swift
//  skyeng-External
//
//  Created by Armen Hakobyan on 15.01.22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    func bind(to model: Word) {
        self.label?.text = model.text
        self.label?.textColor = .defaultTextColor
    }
    
}
