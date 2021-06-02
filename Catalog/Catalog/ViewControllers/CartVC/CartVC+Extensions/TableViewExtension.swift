import UIKit

extension CartVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let itemDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ItemDetails.self)) as? ItemDetails else {return}
            itemDetailsVC.currentProduct = cartItems[indexPath.row]
            navigationController?.pushViewController(itemDetailsVC, animated: true)
        }
    }
}
extension CartVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableModel[indexPath.section][indexPath.row] {
        case .priceOnTop:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PriceOnTop.self), for: indexPath)
            guard let priceOnTopCell = cell as? PriceOnTop else {return cell}
            priceOnTopCell.setLabel(priceOnTop: calcTotalCartPrice())
            return priceOnTopCell
        case .orderBtn:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderButton.self), for: indexPath)
            guard let orderButtonCell = cell as? OrderButton else {return cell}
            return orderButtonCell
        case .itemInCart:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemInCart.self), for: indexPath)
            guard let itemInCartCell = cell as? ItemInCart else {return cell}
            itemInCartCell.cartItem = cartItems[indexPath.row]
            itemInCartCell.setupCell()
            itemInCartCell.deleteDelegate = self
            return itemInCartCell
        case .total:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Total.self), for: indexPath)
            guard let totalCell = cell as? Total else {return cell}
            totalCell.setLabel(totalPrice: calcTotalCartPrice())
            return totalCell
        }
    }
}

extension CartVC: DeletableItem {
    func deleteItem() {
        cartItems = DataManager.shared.cartProducts
        tableModel = CartTableModel.getCells()
        checkCartIsEmpty()
        tableView.reloadData()
    }
}
