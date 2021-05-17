import UIKit

class ItemImage: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func navBackAction(_ sender: Any) {
        func findViewController(responder: UIResponder?) -> UIViewController? {
            if let nextResponder = responder as? UIViewController {
                return nextResponder
            } else {
                return findViewController(responder: responder?.next)
            }
        }
        let currentVC = findViewController(responder: self.next)
        currentVC?.navigationController?.popViewController(animated: true)
    }
    
    func setImage (urlString: String?) {
        guard let urlStr = urlString else {return}
        let screen = UIScreen.main.bounds
        let imgWidth = screen.width
        let placeholderImage = UIImage(named: "dressSample.jpeg")?.resizeImageWithNewWidthPreservingAspectRatio(targetWidth: imgWidth)
        
        itemImage.sd_setImage(with: URL(string: urlStr), placeholderImage: placeholderImage) { img, error, cache, url in
            self.itemImage.image = self.itemImage.image?.resizeImageWithNewWidthPreservingAspectRatio(targetWidth: imgWidth)
        }
    }
}
