import UIKit
import ImageSlideshow

extension ItemDetails: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableModel = DetailsTableModel.getAvailableCells(data: currentProduct)
        return tableModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableModel[indexPath.row] {
        case .itemImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemImage.self), for: indexPath)
            guard let imageCell = cell as? ItemImage else {return cell}
            imageCell.slideshowDelegate = self
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
            sizeChartCell.currentProduct = currentProduct
            sizeChartCell.setSizeChart(currentProduct?.sizeChart)
            sizeChartCell.price = currentProduct?.price
            if let amount = currentProduct?.amountInCart {
                sizeChartCell.amountField.text = "\(amount)"
            }
            sizeChartCell.calcTotalPrice(amount: currentProduct?.amountInCart ?? 1)
            return sizeChartCell
        case .addToCart:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddToCartCell.self), for: indexPath)
            guard let addToCartCell = cell as? AddToCartCell else {return cell}
            addToCartCell.currentProduct = currentProduct
            addToCartCell.setBtnAppearance()
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
