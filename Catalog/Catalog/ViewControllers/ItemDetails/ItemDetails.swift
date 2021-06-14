import UIKit
import ImageSlideshow

class ItemDetails: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var currentProduct: Product?
    var tableModel: [DetailsTableModel] = []
    var slideshow: ImageSlideshow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell([ItemImage.self, ArticleCell.self, PriceCell.self, ColorCell.self, SizeChartCell.self, AddToCartCell.self])
        setFavoriteBtnAppearance()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
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


