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
    @IBOutlet weak var sizesStackView: UIStackView!
    @IBOutlet weak var totalStackView: UIStackView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var currentProduct: Product?
    var price: String?
    var maxSize = 0
    var minSize = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setSizeChart(_ sizeChart: String?) {
        guard let sizesTxt = sizeChart, sizesTxt != "" else {
            sizesStackView.isHidden = true
            totalStackView.isHidden = true
            return
        }
        minSize = (currentProduct?.extractMinMaxSizes()[0])!
        maxSize =  (currentProduct?.extractMinMaxSizes()[1])!
        let sizeChartAttrStr = NSMutableAttributedString(string: "Размеры: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 15)])
        sizeChartAttrStr.append(NSAttributedString(string: "\(minSize)-\(maxSize)"))
      sizeLabel.attributedText = sizeChartAttrStr
    }
    
    func calcTotalPrice(amount: Int) {
        guard let txtPrice = price, let dblPrice = Double(txtPrice) else {
            totalStackView.isHidden = true
            return
        }
        let amountInLineup = ((maxSize - minSize) / 2) + 1
        let total = dblPrice * Double(amount) * Double(amountInLineup)
        totalPriceLabel.text = "\(String(format: "%g", total)) BYN"
    }
    
    @IBAction func minusItemAction(_ sender: UIButton) {
        guard var amount = currentProduct?.amountInCart else {return}
        if amount > 1 {
            amount -= 1
        }
        currentProduct?.amountInCart = amount
        amountField.text = "\(amount)"
        calcTotalPrice(amount: amount)
    }
    
    @IBAction func plusItemAction(_ sender: Any) {
        var amount = currentProduct?.amountInCart ?? 1
        amount += 1
        currentProduct?.amountInCart = amount
        amountField.text = "\(amount)"
        calcTotalPrice(amount: amount)
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let biggerMinusButtonFrame = minusButton.frame.insetBy(dx: -10, dy: -10)
        if biggerMinusButtonFrame.contains(point) {
            return minusButton
        }
        let biggerPlusButtonFrame = plusButton.frame.insetBy(dx: -10, dy: -10)
        if biggerPlusButtonFrame.contains(point) {
            return plusButton
        }
        return super.hitTest(point, with: event)
    }
       

}

