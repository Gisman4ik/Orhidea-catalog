import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var currentFavorites: [Product] = []
    var emptyFavoritesView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        emptyFavoritesView = setupEmptyView(img: UIImage(named: "heartFavorite.png") ?? UIImage(), imgHeight: 150, imgCenterIndent: -50, labelWidth: 300, labelText: "Добавьте в товары в Избранное, чтобы вернуться к ним позже", labelTopIndent: 40)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        currentFavorites = DataManager.shared.favoriteProducts
        checkFavoritesIsEmpty()
        collectionView.reloadData()
    }

    private func registerCell() {
        let productCellNib = UINib(nibName: String(describing: ProductCell.self), bundle: nil)
        collectionView.register(productCellNib, forCellWithReuseIdentifier: String(describing: ProductCell.self))
    }
    func checkFavoritesIsEmpty() {
        if currentFavorites.count <= 0 {
            emptyFavoritesView.isHidden = false
        } else {
            emptyFavoritesView.isHidden = true
        }
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
        productCell.currentProduct = currentFavorites[indexPath.row]
        
        return productCell
    }
}

extension FavoriteVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screen = UIScreen.main.bounds
        let imgWidth = (screen.width / 2) - 1
        return CGSize(width: imgWidth, height: imgWidth * (1200/900) + 100)
    }
}
