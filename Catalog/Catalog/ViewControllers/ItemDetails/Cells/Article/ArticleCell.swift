import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var articleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setArticle(article: String?) {
        guard let strongArticle = article else {return}
        articleLabel.text = strongArticle
    }
}
