import UIKit

class PriceOnTop: UITableViewCell {

    @IBOutlet weak var priceOnTopLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setLabel(priceOnTop: String) {
        priceOnTopLabel.text = "Заказ на сумму \(priceOnTop) р."
    }
}
