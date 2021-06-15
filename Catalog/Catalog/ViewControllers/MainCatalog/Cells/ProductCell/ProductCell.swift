import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productSizeChart: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productImgWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var currentProduct: Product? {
        didSet {
            setupProductInfo()
            setFavoriteBtnAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        productImage.image = nil
    }
    func setupProductInfo() {
        guard let product = currentProduct else { return }
        if let title = product.title {
            productTitle.text = title
        }
       
        if let sizes = product.sizeChart {
            productSizeChart.text = sizes
        }
        
        if let dblQuantity = Double(product.quantity) {
            dblQuantity <= 0 ? (productQuantity.text = "Нет в наличии") : (productQuantity.text = "")
        } else {
            productQuantity.text = "Нет в наличии"
        }
        
        let screen = UIScreen.main.bounds
        let imgWidth = (screen.width / 2) - 1
        let placeholderImage = UIImage(named: "dressPlaceholder.png")
        productImgWidthConstraint.constant = imgWidth
        
        if let picUrl = product.imageURLString {
            productImage.sd_setImage(with: URL(string: picUrl), placeholderImage: placeholderImage)
        }
    }
    
    func setFavoriteBtnAppearance() {
        guard let product = currentProduct else {return}
        if product.isInFavorite {
            favoriteButton.isSelected = true
        }
        else {
            favoriteButton.isSelected = false
        }
    }
    
    @IBAction func addToFavoriteAction(_ sender: Any) {
        guard let product = currentProduct else {return}
        if product.isInFavorite {
            product.removeFromFavorite()
        }
        else {
            product.addToFavorite()
        }
        setFavoriteBtnAppearance()
    }
}
