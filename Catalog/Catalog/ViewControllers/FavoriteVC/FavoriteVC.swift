import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var currentFavorites: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        currentFavorites = DataManager.shared.favoriteProducts
        collectionView.reloadData()
    }
    private func registerCell() {
        let productCellNib = UINib(nibName: String(describing: ProductCell.self), bundle: nil)
        collectionView.register(productCellNib, forCellWithReuseIdentifier: String(describing: ProductCell.self))
    }
}

extension FavoriteVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ItemDetails.self)) as? ItemDetails else {return}
        
        itemDetailsVC.currentProduct = currentFavorites[indexPath.row]
        navigationController?.pushViewController(itemDetailsVC, animated: true)
    }
}
extension FavoriteVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentFavorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCell.self), for: indexPath)
        guard let productCell = cell as? ProductCell else {return cell}
        let product = currentFavorites[indexPath.row]
        guard let productTitle = product.title, let productImageURLString = product.imageURLString else {return cell}
        productCell.currentProduct = product
        productCell.setupProductInfo(title: productTitle, quantity: product.quantity, sizeChart: product.sizeChart, imageURLString: productImageURLString)
        productCell.setFavoriteBtnAppearance()
        return productCell
    }
    
    
}
