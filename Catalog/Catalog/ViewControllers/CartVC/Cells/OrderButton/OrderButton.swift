import UIKit

class OrderButton: UITableViewCell {

    @IBOutlet weak var orderButton: UIButton!
    
    var action: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func makeAnOrderAction(_ sender: Any) {
        action?()
    }
    
}
