import UIKit
import SDWebImage
class CatalogVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var catalogSearchBar: UISearchBar!
    @IBOutlet weak var quantitySwitch: UISwitch!

    let loadingView = UIView()
    var closeKeyboardByTap = UITapGestureRecognizer()
    var isOpenKeyboard = false
    var isEmptySearchBar: Bool {
      return catalogSearchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerCell([ProductCell.self])
        setVCAppearance()
        getCatalogData()
        setCloseKeyboardTapGesture()
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadVisibleCells()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    @IBAction func quantityFilterAction(_ sender: Any) {
        guard let catalogData = DataManager.shared.catalogData else {return}
        DataManager.shared.filteredCatalogProducts = catalogData.products
        if !isEmptySearchBar {
            filterContentForSearchText(catalogSearchBar.text!)
        }
        else {
            filterByQuantity()
        }
        collectionView.setContentOffset(.zero, animated: false)
        collectionView.reloadData()
    }
    @objc func keyboardWillAppear() {
        isOpenKeyboard = true
    }
    @objc func keyboardWillDisappear() {
        isOpenKeyboard = false
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    private func setCloseKeyboardTapGesture() {
        closeKeyboardByTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(closeKeyboardByTap)
        closeKeyboardByTap.delegate = self
    }
   fileprivate func filterByQuantity() {
        if quantitySwitch.isOn {
            DataManager.shared.filteredCatalogProducts = DataManager.shared.filteredCatalogProducts.filter { product in
                guard let quantity = Double(product.quantity) else {return false}
                return quantity > 0
            }
        }
    }
    private func reloadVisibleCells() {
        let indexPathsForVisibleItems =
            collectionView.indexPathsForVisibleItems
        collectionView.reloadItems(at: indexPathsForVisibleItems)
    }
    private func setVCAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = nil
        navigationController?.navigationBar.standardAppearance = navBarAppearance
    }
    fileprivate func filterContentForSearchText(_ searchText: String) {
        guard let catalogData = DataManager.shared.catalogData else {return}
        DataManager.shared.filteredCatalogProducts = catalogData.products.filter { (product: Product) -> Bool in
            guard let title = product.title else {return false}
            return title.lowercased().contains(searchText.lowercased())
        }
        filterByQuantity()
        collectionView.reloadData()
    }
}

extension CatalogVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !isEmptySearchBar {
            filterContentForSearchText(searchBar.text!)
        }
        else {
            guard let catalogData = DataManager.shared.catalogData else {return}
            DataManager.shared.filteredCatalogProducts = catalogData.products
            collectionView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

extension CatalogVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer == self.closeKeyboardByTap && isOpenKeyboard{
            return true
        }
        return false
    }
}
