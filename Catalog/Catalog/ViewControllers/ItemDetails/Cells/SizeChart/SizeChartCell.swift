//
//  SizeCell.swift
//  Catalog
//
//  Created by Artur Radziukhin on 1.05.21.
//

import UIKit

class SizeChartCell: UITableViewCell {

    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var price = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setSizeChart(_ sizeChart: String?) {
        guard let sizes = sizeChart else {return}
        sizeLabel.text = sizes
    }
    
    func calcTotalPrice(amount: Int) {
        let total = price * Double(amount) * 6.0
        totalPriceLabel.text = "\(String(format: "%g", total)) BYN"
    }
    
    @IBAction func minusItemAction(_ sender: Any) {
        guard let amountTxtValue = amountField.text, var amountValue = Int(amountTxtValue) else {return}
        if amountValue > 1 {
            amountValue -= 1
        }
        amountField.text = "\(amountValue)"
        calcTotalPrice(amount: amountValue)
    }
    @IBAction func plusItemAction(_ sender: Any) {
        guard let amountTxtValue = amountField.text, var amountValue = Int(amountTxtValue) else {return}
        amountValue += 1
        amountField.text = "\(amountValue)"
        calcTotalPrice(amount: amountValue)
    }
    
    
}
