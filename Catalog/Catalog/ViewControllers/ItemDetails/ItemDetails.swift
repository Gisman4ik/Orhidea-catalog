import UIKit
import ImageSlideshow
class ItemDetails: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentProduct: Product?
    var tableModel: [DetailsTableModel] = []
    var slideshow: ImageSlideshow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setGestureFullSlideShow() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        guard let slideShow = slideshow else {return}
        slideShow.addGestureRecognizer(gestureRecognizer)
    }
    @objc func didTap() {
        guard let slideShow = slideshow else {return}
       let fullScreenController = slideShow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator()
    }
    private func registerCell() {
        let imageCell = UINib(nibName: String(describing: ItemImage.self), bundle: nil)
        let articleCell = UINib(nibName: String(describing: ArticleCell.self), bundle: nil)
        let priceCell = UINib(nibName: String(describing: PriceCell.self), bundle: nil)
        let colorCell = UINib(nibName: String(describing: ColorCell.self), bundle: nil)
        let sizeChartCell = UINib(nibName: String(describing: SizeChartCell.self), bundle: nil)
        let addToCartCell = UINib(nibName: String(describing: AddToCartCell.self), bundle: nil)
        
        tableView.register(imageCell, forCellReuseIdentifier: String(describing: ItemImage.self))
        tableView.register(articleCell, forCellReuseIdentifier: String(describing: ArticleCell.self))
        tableView.register(priceCell, forCellReuseIdentifier: String(describing: PriceCell.self))
        tableView.register(colorCell, forCellReuseIdentifier: String(describing: ColorCell.self))
        tableView.register(sizeChartCell, forCellReuseIdentifier: String(describing: SizeChartCell.self))
        tableView.register(addToCartCell, forCellReuseIdentifier: String(describing: AddToCartCell.self))
    }
}

extension ItemDetails: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel = DetailsTableModel.itemImage.getAvailableCells(data: currentProduct)
        return tableModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableModel[indexPath.row] {
        case .itemImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemImage.self), for: indexPath)
            guard let imageCell = cell as? ItemImage else {return cell}
            imageCell.slideshowDelegate = self
            imageCell.goBackDelegate = self
            imageCell.setImages(gallery: currentProduct?.gallery)
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
        case .color:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ColorCell.self), for: indexPath)
            guard let colorCell = cell as? ColorCell else {return cell}
            colorCell.setColor(color: currentProduct?.color)
            return colorCell
        case .sizeChart:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SizeChartCell.self), for: indexPath)
            guard let sizeChartCell = cell as? SizeChartCell else {return cell}
            sizeChartCell.setSizeChart(currentProduct?.sizeChart)
            sizeChartCell.price = currentProduct?.price
            sizeChartCell.calcTotalPrice(amount: 1)
            return sizeChartCell
        case .addToCart:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddToCartCell.self), for: indexPath)
            guard let addToCartCell = cell as? AddToCartCell else {return cell}
            return addToCartCell
        }
    }
}

extension ItemDetails: SlideshowDelegate {
    func sendSlideShow(_ slideshow: ImageSlideshow){
        self.slideshow = slideshow
        self.setGestureFullSlideShow() 
    }
}
extension ItemDetails: GoBackDelegate {
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}
