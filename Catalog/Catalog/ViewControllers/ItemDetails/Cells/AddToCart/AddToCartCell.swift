import UIKit

class AddToCartCell: UITableViewCell {
    @IBOutlet weak var addToCartBtn: UIButton!
    
    var currentProduct: Product?
    var productAmount = 1
    var amountDelegate: ProductAmountDelegate?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func addToCartAction(_ sender: Any) {
        guard let product = currentProduct else {return}
        if let amount = amountDelegate?.sendProductAmount() {
            productAmount = amount
        }
        if product.isInCart {
            if let tabBarController = self.window!.rootViewController as? UITabBarController {
                tabBarController.selectedIndex = 2
            }
        }
        else {
            product.addToCart(amount: productAmount)
        }
        setBtnAppearance()
    }
    func setBtnAppearance() {
        addToCartBtn.setTitle("Перейти в корзину", for: .normal)
    }
}
