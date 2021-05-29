//
//  Total.swift
//  Catalog
//
//  Created by Artur Radziukhin on 28.05.21.
//

import UIKit

class Total: UITableViewCell {

    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setLabel(totalPrice: String) {
        totalPriceLabel.text = "\(totalPrice) р."
    }
    
}
