import UIKit

class OrderInfoCell: UITableViewCell {

    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setInfoLabel(infoText: String) {
        infoLabel.text = "\(infoText)"
    }
}
