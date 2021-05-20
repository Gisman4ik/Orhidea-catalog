import UIKit
import ImageSlideshow

class ItemImage: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    var slideshowDelegate: SlideshowDelegate?
    var goBackDelegate: GoBackDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func navBackAction(_ sender: Any) {
        goBackDelegate?.popVC()
    }
    
    func setImages (gallery: String?) {
        guard let galleryStr = gallery else {return}
        let imagesURLs = detectURLsFromStr(galleryStr)
        var sdWebImageSource: [SDWebImageSource] = []
        for urlString in imagesURLs {
            let source = SDWebImageSource(urlString: urlString)
            if let sdWebSource = source {
                sdWebImageSource.append(sdWebSource)
            }
        }
        slideshowDelegate?.sendSlideShow(slideshow)
        slideshow.setImageInputs(sdWebImageSource)
        slideshow.zoomEnabled = true
        slideshow.activityIndicator = DefaultActivityIndicator()
    }
    private func detectURLsFromStr (_ string: String) -> [String] {
        let validString = string.replacingOccurrences(of: "\\", with: "")
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: validString, options: [], range: NSRange(location: 0, length: validString.utf16.count))
        var result: [String] = []
        for match in matches {
            guard let range = Range(match.range, in: validString) else { continue }
            let url = validString[range]
            result.append(String(url))
        }
        return result
    }
}
