import UIKit
import SDWebImage
class CatalogVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let loadingView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerCell([ProductCell.self])
        setVCAppearance()
        getCatalogData()
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadVisibleCells()
    }
    
    @IBAction func quantityFilterAction(_ sender: UISwitch) {
        if sender.isOn {
            DataManager.shared.filteredCatalogProducts = DataManager.shared.filteredCatalogProducts.filter { product in
                guard let quantity = Double(product.quantity) else {return false}
                return quantity > 0
            }
        }
        else {
            DataManager.shared.filteredCatalogProducts = DataManager.shared.catalogData!.products
        }
        collectionView.setContentOffset(.zero, animated: false)
        collectionView.reloadData()
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
}
