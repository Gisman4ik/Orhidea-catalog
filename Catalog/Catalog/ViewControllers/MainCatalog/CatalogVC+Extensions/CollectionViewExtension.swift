import UIKit

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
        let product = DataManager.shared.filteredCatalogProducts[indexPath.row]
        guard let productTitle = product.title, let productImageURLString = product.imageURLString else {return cell}
        productCell.currentProduct = product
        productCell.setupProductInfo(title: productTitle, quantity: product.quantity, sizeChart: product.sizeChart, imageURLString: productImageURLString)
        productCell.setFavoriteBtnAppearance()
        return productCell
    }
}
