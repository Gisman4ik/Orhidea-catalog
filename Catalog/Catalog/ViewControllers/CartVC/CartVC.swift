import UIKit

class CartVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var tableModel = CartTableModel.getCells()
    var cartItems: [Product] = []
    var emptyCartView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmptyCartView()
        tableView.registerCell([PriceOnTop.self,OrderButton.self,ItemInCart.self,Total.self])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        tableModel = CartTableModel.getCells()
        cartItems = DataManager.shared.cartProducts
        checkCartIsEmpty()
        tableView.reloadData()
    }
    
    func calcTotalCartPrice () -> String {
        var totalPrice = 0.0
        for item in cartItems {
            guard let amount = item.amountInCart, let price = item.price, let dblPrice = Double(price) else {return "0"}
            let amountInLineUp = ((item.extractMinMaxSizes()[1] - item.extractMinMaxSizes()[0]) / 2) + 1
            totalPrice += Double(amount) * dblPrice * Double(amountInLineUp)
        }
        return "\(String(format: "%g", totalPrice))"
    }
    
    func checkCartIsEmpty() {
        if cartItems.count <= 0 {
            tableModel = []
            emptyCartView.isHidden = false
        }
        else {
            emptyCartView.isHidden = true
        }
    }
}
