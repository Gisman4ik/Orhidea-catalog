import UIKit

class OrderInfoDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableInfo: [[String]] {
        return [getCustomerInfoDetails(), getOrderInfoDetails()]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarWithSubTitle(step: "3")
        tableView.registerCell([OrderInfoCell.self])
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func getCustomerInfoDetails() -> [String]{
        let customerSave = RealmManager.shared.readCustomerSave()
        guard let customerInfo = customerSave else {return []}
        var infoArray: [String] = []
        if !customerInfo.name.isEmpty {
            infoArray.append("Имя: \(customerInfo.name)")
        }
        if let surName = customerInfo.surName, !surName.isEmpty {
            infoArray.append("Фамилия: \(surName)")
        }
        if !customerInfo.tel.isEmpty {
            infoArray.append("Телефон: \(customerInfo.tel)")
        }
        if let email = customerInfo.email, !email.isEmpty {
            infoArray.append("E-mail: \(email)")
        }
        if !customerInfo.country.isEmpty {
            infoArray.append("Страна: \(customerInfo.country)")
        }
        if !customerInfo.city.isEmpty {
            infoArray.append("Город: \(customerInfo.city)")
        }
        if let address = customerInfo.address, !address.isEmpty {
            infoArray.append("Адрес: \(address)")
        }
        if let apartmentNum = customerInfo.apartmentNum, !apartmentNum.isEmpty {
            infoArray.append("Номер помещения: \(apartmentNum)")
        }
        if let postcode = customerInfo.postcode, !postcode.isEmpty {
            infoArray.append("Почтовый индекс: \(postcode)")
        }
        return infoArray
    }
    func getOrderInfoDetails() -> [String] {
        var orderArray: [String] = []
        DataManager.shared.cartProducts.enumerated().forEach { index, product  in
            if let amount = product.amountInCart, let title = product.title {
                orderArray.append("\(title) X \(amount) ряда(ов)")
            }
        }
        if let cartVC = self.navigationController?.viewControllers.first as? CartVC {
            orderArray.append("Итого: \(cartVC.totalPrice) BYN")
        }
        return orderArray
    }
}

extension OrderInfoDetailsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableInfo.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableInfo[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderInfoCell.self), for: indexPath)
        guard let infoCell = cell as? OrderInfoCell else {return cell}
        infoCell.setInfoLabel(infoText: tableInfo[indexPath.section][indexPath.row])
        return infoCell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Персональные данные"
        } else if section == 1 {
            return "Данные о заказе"
        } else {return nil}
    }
    
}
