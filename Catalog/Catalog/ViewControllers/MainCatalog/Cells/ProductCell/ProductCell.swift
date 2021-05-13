import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productSizeChart: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupProductInfo(title: String, price: String, sizeChart: String, imageURLString: String) {
        productTitle.text = title
        productSizeChart.text = sizeChart
        productPrice.text = price
        
        let screen = UIScreen.main.bounds
        let imgWidth = (screen.width / 2) - 1
        let placeholderImage = UIImage(named: "dressSample.png")?.resizeImageWithNewWidthPreservingAspectRatio(targetWidth: imgWidth)
        productImage.sd_setImage(with: URL(string: imageURLString), placeholderImage: placeholderImage) { img, error, imgCache, URL in
            self.productImage.image = self.productImage.image?.resizeImageWithNewWidthPreservingAspectRatio(targetWidth: imgWidth)
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
