import UIKit

extension UICollectionView {
    func registerCell(_ cellsClases: [AnyClass]) {
        cellsClases.forEach { cellClass in
            let nib = UINib(nibName: String(describing: cellClass.self), bundle: nil)
            self.register(nib, forCellWithReuseIdentifier: String(describing: cellClass.self))
        }
    }
    func setupDelegateData(_ controller: UIViewController) {
        self.delegate = controller as? UICollectionViewDelegate
        self.dataSource = controller as? UICollectionViewDataSource
    }
}
