import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productSizeChart: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productImgWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupProductInfo(title: String, quantity: String, sizeChart: String?, imageURLString: String) {
        productTitle.text = title
        if let sizes = sizeChart {
            productSizeChart.text = sizes
        }
        if let dblQuantity = Double(quantity) {
            dblQuantity <= 0 ? (productQuantity.text = "Нет в наличии") : (productQuantity.text = "")
        }
        else { productQuantity.text = "Нет в наличии" }
        let screen = UIScreen.main.bounds
        let imgWidth = (screen.width / 2) - 1
        let placeholderImage = UIImage(named: "dressSample.jpeg")
        productImgWidthConstraint.constant = imgWidth
        productImage.sd_setImage(with: URL(string: imageURLString), placeholderImage: placeholderImage, options: [.avoidAutoSetImage]) { img, error, imgCache, URL in
            guard let img = img else {return}
            self.productImage.image = img
        }
    }
}


extension UIImage {
    func resizeImageWithNewWidthPreservingAspectRatio(targetWidth: CGFloat) -> UIImage {
        let heightRatio = size.height / size.width
        let widthRatio = size.width / size.height
        let scaleFactor = max(widthRatio, heightRatio)
        let scaledImageSize = CGSize(
            width: targetWidth,
            height: targetWidth * scaleFactor
        )
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        return scaledImage
    }
}
