import UIKit

class CartVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var tableModel = CartTableModel.itemInCart.getCells()
    var cartItems: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        tableModel = CartTableModel.itemInCart.getCells()
        cartItems = DataManager.shared.cartProducts
        ifCartIsEmpty()
        tableView.reloadData()
    }
    
    func registerCells() {
        let priceOnTopCell = UINib(nibName: String(describing: PriceOnTop.self), bundle: nil)
        let orderButtonCell = UINib(nibName: String(describing: OrderButton.self), bundle: nil)
        let itemInCartCell = UINib(nibName: String(describing: ItemInCart.self), bundle: nil)
        let totalCell = UINib(nibName: String(describing: Total.self), bundle: nil)
        
        tableView.register(priceOnTopCell, forCellReuseIdentifier: String(describing: PriceOnTop.self))
        tableView.register(orderButtonCell, forCellReuseIdentifier: String(describing: OrderButton.self))
        tableView.register(itemInCartCell, forCellReuseIdentifier: String(describing: ItemInCart.self))
        tableView.register(totalCell, forCellReuseIdentifier: String(describing: Total.self))
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
    
    func ifCartIsEmpty() {
        if cartItems.count <= 0 {
            tableModel = []
        }
    }
}




