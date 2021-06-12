import UIKit

class CartVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fixedOrderView: UIView!
    @IBOutlet weak var fixedOrderButton: UIButton!
    
    var tableModel = CartTableModel.getCells()
    var cartItems: [Product] = []
    var emptyCartView = UIView()
    var orderButtonOffset: CGRect = CGRect()
    var orderButtonIndexPath: IndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixedOrderButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
        setupEmptyCartView()
        tableView.registerCell([PriceOnTop.self,OrderButton.self,ItemInCart.self,Total.self])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        tableModel = CartTableModel.getCells()
        cartItems = DataManager.shared.cartProducts
        checkCartIsEmpty()
        setFixedOrderBtnAppearance()
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        orderButtonOffset = tableView.rectForRow(at: orderButtonIndexPath)
    }
    func setFixedOrderBtnAppearance() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let btnTitleStr = NSMutableAttributedString(string: "Перейти к оформлению заказа\n",attributes: [.paragraphStyle: paragraphStyle])
        btnTitleStr.append(NSAttributedString(string: "\(calcTotalCartPrice()) р.", attributes: [.font: UIFont.systemFont(ofSize: 15),.paragraphStyle: paragraphStyle]))
        fixedOrderButton.setAttributedTitle(btnTitleStr, for: .normal)
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
