//
//  ColorCell.swift
//  Catalog
//
//  Created by Artur Radziukhin on 19.05.21.
//

import UIKit

class ColorCell: UITableViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setColor(color: String?) {
        guard let colour = color else {return}
        let colorStr = NSMutableAttributedString(string: "Цвет: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 15)])
        colorStr.append(NSAttributedString(string: colour.lowercased()))
        colorLabel.attributedText = colorStr
    }
    
}
