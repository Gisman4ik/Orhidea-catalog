import UIKit
import SDWebImage
class CatalogVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let loadingView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVCAppearance()
        getCatalogData()
    }
    
    private func registerCell() {
        let productCellNib = UINib(nibName: String(describing: ProductCell.self), bundle: nil)
        collectionView.register(productCellNib, forCellWithReuseIdentifier: String(describing: ProductCell.self))
    }
    func setVCAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = nil
        navigationController?.navigationBar.standardAppearance = navBarAppearance
    }
    func getCatalogData() {
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        setLoadingView()
        NetworkManager.shared.getCatalogData { [self] (result) in
            DataManager.shared.catalogData = result
            DataManager.shared.filteredCatalogProducts = result.products
            registerCell()
            collectionView.reloadData()
            loadingView.isHidden = true
            navigationController?.isNavigationBarHidden = false
            tabBarController?.tabBar.isHidden = false
        } failure: { error in
            print(error)
        }
    }
    func setLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.backgroundColor = #colorLiteral(red: 0.9763647914, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        view.addSubview(loadingView)
        let margins = view.safeAreaLayoutGuide
        let viewConstraints = [
            loadingView.topAnchor.constraint(equalTo: margins.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            loadingView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ]
        NSLayoutConstraint.activate(viewConstraints)
        
        let logoImg = UIImage(named: "LogoDressesBlack.png")
        let logoImgView = UIImageView(image: logoImg)
        logoImgView.contentMode = .scaleAspectFit
        loadingView.addSubview(logoImgView)
        logoImgView.translatesAutoresizingMaskIntoConstraints = false
        let imgViewConstraints = [
            logoImgView.topAnchor.constraint(equalTo: loadingView.topAnchor),
            logoImgView.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor),
            logoImgView.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor),
            logoImgView.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(imgViewConstraints)
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
            collectionView.reloadData()
    }
}

extension CatalogVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let itemDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ItemDetails.self)) as? ItemDetails else {return}
        itemDetailsVC.currentProduct = DataManager.shared.filteredCatalogProducts[indexPath.row]
        navigationController?.pushViewController(itemDetailsVC, animated: true)
        
    }
}

extension CatalogVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.filteredCatalogProducts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCell.self), for: indexPath)
        guard let productCell = cell as? ProductCell else {return cell}
        let productInfo = DataManager.shared.filteredCatalogProducts[indexPath.row]
        guard let productTitle = productInfo.title, let productImageURLString = productInfo.imageURLString else {return cell}
        
        productCell.setupProductInfo(title: productTitle, quantity: productInfo.quantity, sizeChart: productInfo.sizeChart, imageURLString: productImageURLString)
        return productCell
    }
}

