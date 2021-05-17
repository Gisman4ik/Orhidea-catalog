import UIKit

class ItemDetails: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableModel = DetailsTableModel.allCases
    var currentProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func registerCell() {
        let imageCell = UINib(nibName: String(describing: ItemImage.self), bundle: nil)
        let articleCell = UINib(nibName: String(describing: ArticleCell.self), bundle: nil)
        let priceCell = UINib(nibName: String(describing: PriceCell.self), bundle: nil)
        let sizeChartCell = UINib(nibName: String(describing: SizeChartCell.self), bundle: nil)
        let addToCartCell = UINib(nibName: String(describing: AddToCartCell.self), bundle: nil)
        let aboutCell = UINib(nibName: String(describing: AboutCell.self), bundle: nil)

        
        tableView.register(imageCell, forCellReuseIdentifier: String(describing: ItemImage.self))
        tableView.register(articleCell, forCellReuseIdentifier: String(describing: ArticleCell.self))
        tableView.register(priceCell, forCellReuseIdentifier: String(describing: PriceCell.self))
        tableView.register(sizeChartCell, forCellReuseIdentifier: String(describing: SizeChartCell.self))
        tableView.register(addToCartCell, forCellReuseIdentifier: String(describing: AddToCartCell.self))
        tableView.register(aboutCell, forCellReuseIdentifier: String(describing: AboutCell.self))
    }
    
}

extension ItemDetails: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableModel[indexPath.row] {
        case .itemImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemImage.self), for: indexPath)
            guard let imageCell = cell as? ItemImage else {return cell}
            imageCell.setImage(urlString: currentProduct?.imageURLString)
            return imageCell
        case .article:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleCell.self), for: indexPath)
            guard let articleCell = cell as? ArticleCell else {return cell}
            articleCell.setArticle(article: currentProduct?.title)
            return articleCell
        case .price:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PriceCell.self), for: indexPath)
            guard let priceCell = cell as? PriceCell else {return cell}
            priceCell.setPrice(price: currentProduct?.price)
            return priceCell
        case .sizeChart:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SizeChartCell.self), for: indexPath)
            guard let sizeChartCell = cell as? SizeChartCell else {return cell}
            sizeChartCell.setSizeChart(currentProduct?.sizeChart)
            guard let txtPrice = currentProduct?.price, let price = Double(txtPrice) else {return cell}
            sizeChartCell.price = price
            sizeChartCell.calcTotalPrice(amount: 1)
            return sizeChartCell
        case .addToCart:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddToCartCell.self), for: indexPath)
            guard let addToCartCell = cell as? AddToCartCell else {return cell}
            return addToCartCell
        case .about:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AboutCell.self), for: indexPath)
            guard let aboutCell = cell as? AboutCell else {return cell}
            return aboutCell
        }
    }
}
