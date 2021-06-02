import UIKit

extension UITableView {
    func registerCell(_ cellsClases: [AnyClass]) {
        cellsClases.forEach { cellClass in
            let nib = UINib(nibName: String(describing: cellClass.self), bundle: nil)
            self.register(nib, forCellReuseIdentifier: String(describing: cellClass.self))
        }
    }
    func setupDelegateData(_ controller: UIViewController) {
        self.delegate = controller as? UITableViewDelegate
        self.dataSource = controller as? UITableViewDataSource
        self.tableFooterView = UIView()
    }
}
