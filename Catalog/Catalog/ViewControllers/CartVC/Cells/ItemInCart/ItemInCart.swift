import UIKit

class ItemInCart: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productImgWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var productInfoLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var cartItem: Product?
    weak var tableViewDelegate: (DeletableItem & Updatable)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setupCell() {
        setProductImage()
        setInfo()
    }
    func setProductImage() {
        let screen = UIScreen.main.bounds
        let imgWidth = (screen.width / 3)
        let placeholderImage = UIImage(named: "dressSample.jpeg")
        productImgWidthConstraint.constant = imgWidth
        guard let imgUrl = cartItem?.imageURLString else {return}
        productImage.sd_setImage(with: URL(string: imgUrl), placeholderImage: placeholderImage)
    }
    func setInfo() {
        guard let product = cartItem else {return}
        guard let title = product.title, let color = product.color else {return}
        let amount = product.amountInCart ?? 1
        let minSize = (product.extractMinMaxSizes()[0])
        let maxSize =  (product.extractMinMaxSizes()[1])
        productInfoLabel.text = """
            \(title)
            Размеры: \(minSize)-\(maxSize)
            Цвет: \(color.lowercased())
            Количество рядов:
            """
        amountLabel.text = "\(amount)"
        guard let price = product.price, let dblPrice = Double(price) else {return}
        let amountInLineup = ((maxSize - minSize) / 2) + 1
        let total = dblPrice * Double(amount) * Double(amountInLineup)
        productPriceLabel.text = "\(String(format: "%g", total)) р."
    }
    @IBAction func plusAmountAction(_ sender: Any) {
        if cartItem?.amountInCart != nil {
            cartItem?.amountInCart! += 1
            RealmManager.shared.updateCartItemAmount(uid: cartItem?.uid, amount: cartItem?.amountInCart)
            tableViewDelegate?.update()
        }
        else {
            cartItem?.amountInCart = 2
            RealmManager.shared.updateCartItemAmount(uid: cartItem?.uid, amount: cartItem?.amountInCart)
            tableViewDelegate?.update()
        }
    }
    @IBAction func minusAmountAction(_ sender: Any) {
        if cartItem?.amountInCart != nil {
            if (cartItem?.amountInCart)! > 1 {
                cartItem?.amountInCart! -= 1
                RealmManager.shared.updateCartItemAmount(uid: cartItem?.uid, amount: cartItem?.amountInCart)
                tableViewDelegate?.update()
            }
        }
        else {
            cartItem?.amountInCart = 1
            RealmManager.shared.updateCartItemAmount(uid: cartItem?.uid, amount: cartItem?.amountInCart)
            tableViewDelegate?.update()
        }
    }
    @IBAction func deleteItemFromCartAction(_ sender: Any) {
        cartItem?.removeFromCart()
        if let tabBarController = self.window!.rootViewController as? UITabBarController {
            guard let currentBadgeValue = tabBarController.tabBar.items?[2].badgeValue ,let currentIntBadgeValue = Int(currentBadgeValue) else {return}
            if currentIntBadgeValue <= 1 {
                tabBarController.tabBar.items?[2].badgeValue = nil
            }
            else {
                tabBarController.tabBar.items?[2].badgeValue = "\(currentIntBadgeValue - 1)"
            }
        }
        tableViewDelegate?.deleteItem()
    }
    
}
