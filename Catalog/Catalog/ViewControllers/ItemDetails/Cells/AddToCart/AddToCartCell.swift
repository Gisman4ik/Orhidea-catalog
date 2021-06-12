import UIKit

class AddToCartCell: UITableViewCell {
    @IBOutlet weak var addToCartBtn: UIButton!
    
    var currentProduct: Product?
    var productAmount = 1
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func addToCartAction(_ sender: Any) {
        guard let product = currentProduct else {return}
        if let amount = currentProduct?.amountInCart {
            productAmount = amount
        }
        if product.isInCart {
            if let tabBarController = self.window!.rootViewController as? UITabBarController {
                tabBarController.selectedIndex = 2
                RealmManager.shared.updateCartItemAmount(uid: currentProduct?.uid, amount: currentProduct?.amountInCart)
                if let navVc = tabBarController.selectedViewController as? UINavigationController {
                    navVc.popToRootViewController(animated: true)
                }
            }
        }
        else {
            product.addToCart(amount: productAmount)
            if let tabBarController = self.window!.rootViewController as? UITabBarController {
                let currentBadgeValue = tabBarController.tabBar.items?[2].badgeValue ?? "0"
                let currentIntBadgeValue = Int(currentBadgeValue) ?? 0
                tabBarController.tabBar.items?[2].badgeValue = "\(currentIntBadgeValue + 1)"
            }
        }
        setBtnAppearance()
    }
    func setBtnAppearance() {
        guard let product = currentProduct else {
            return}
        if product.isInCart {
            addToCartBtn.setTitle("Перейти в корзину", for: .normal)
        }
        else {
            addToCartBtn.setTitle("Добавить ряды в корзину", for: .normal)
        }
    }
}
