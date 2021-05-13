import UIKit

class CatalogVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var catalogData: CatalogData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    func registerCell() {
        let nib = UINib(nibName: String(describing: ProductCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: ProductCell.self))
    }
}

extension CatalogVC: UITableViewDelegate {
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
        
        productCell.setupProductInfo(title: productTitle, price: productInfo.price, sizeChart: productInfo.sizeChart, imageURLString: productImageURLString)
        
        return productCell
    }
}

extension CatalogVC: UICollectionViewDelegateFlowLayout {
}
