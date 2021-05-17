//
//  PriceCell.swift
//  Catalog
//
//  Created by Artur Radziukhin on 15.05.21.
//

import UIKit

class PriceCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setPrice(price: String?) {
        guard let txtPrice = price, let dblPrice = Double(txtPrice) else {return}
        priceLabel.text = "\(String(format: "%g", dblPrice)) BYN / 1 шт."
    }
    
}
