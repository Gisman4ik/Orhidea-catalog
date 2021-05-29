import UIKit
import ImageSlideshow
class ItemDetails: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var currentProduct: Product?
    var tableModel: [DetailsTableModel] = []
    var slideshow: ImageSlideshow?
    var chosenAmount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setFavoriteBtnAppearance()
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func goBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func addToFavoriteAction(_ sender: Any) {
        guard let product = currentProduct else {return}
        if product.isInFavorite {
            product.removeFromFavorite()
        }
        else {
            product.addToFavorite()
        }
        setFavoriteBtnAppearance()
    }
    private func registerCells() {
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
    func setFavoriteBtnAppearance() {
        guard let product = currentProduct else {return}
        if product.isInFavorite {
            favoriteButton.isSelected = true
        }
        else {
            favoriteButton.isSelected = false
        }
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
}


