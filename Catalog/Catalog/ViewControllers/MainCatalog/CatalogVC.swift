import UIKit

class CatalogVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var catalogData: CatalogData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        navigationItem.hidesBackButton = true
    }
    private func registerCell() {
        let productCellNib = UINib(nibName: String(describing: ProductCell.self), bundle: nil)
        collectionView.register(productCellNib, forCellWithReuseIdentifier: String(describing: ProductCell.self))
    }
}

extension CatalogVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ItemDetails.self)) as? ItemDetails else {return}
        itemDetailsVC.currentProduct = catalogData?.products[indexPath.row]
        navigationController?.pushViewController(itemDetailsVC, animated: true)
        
    }
}

extension CatalogVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let catalog = catalogData else {return 0}
        return catalog.products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCell.self), for: indexPath)
        guard let productCell = cell as? ProductCell else {return cell}
        guard let catalog = catalogData else {return cell}
        let productInfo = catalog.products[indexPath.row]
        guard let productTitle = productInfo.title, let productImageURLString = productInfo.imageURLString else {return cell}
        
        productCell.setupProductInfo(title: productTitle, quantity: productInfo.quantity, sizeChart: productInfo.sizeChart, imageURLString: productImageURLString)
        return productCell
    }
}

extension CatalogVC: UICollectionViewDelegateFlowLayout {
}
