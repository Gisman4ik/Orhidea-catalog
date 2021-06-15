import UIKit
extension UIViewController {
    func setupEmptyView(img: UIImage, imgHeight: CGFloat, imgCenterIndent: CGFloat, labelWidth: CGFloat, labelText: String, labelTopIndent: CGFloat) -> UIView {
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.backgroundColor = UIColor(named: "CatalogWhiteColor")
        self.view.addSubview(emptyView)
        let margins = self.view.safeAreaLayoutGuide
        let viewConstraints = [
            emptyView.topAnchor.constraint(equalTo: margins.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            emptyView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ]
        NSLayoutConstraint.activate(viewConstraints)
        let iconView = createEmptyViewImg(emptyView, img, imgHeight, imgCenterIndent)
        createEmptyViewLabel(emptyView, iconView, labelWidth, labelText, labelTopIndent)
        emptyView.isHidden = true
        return emptyView
    }
    
    func createEmptyViewImg(_ emptyView: UIView, _ img: UIImage, _ imgHeight: CGFloat, _ imgCenterIndent: CGFloat) -> UIImageView{
        let margins = self.view.safeAreaLayoutGuide
        let emptyViewImg = UIImageView(image: img)
        emptyViewImg.contentMode = .scaleAspectFit
        emptyView.addSubview(emptyViewImg)
        emptyViewImg.translatesAutoresizingMaskIntoConstraints = false
        let imgViewConstraints = [
            emptyViewImg.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyViewImg.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: imgCenterIndent),
            emptyViewImg.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            emptyViewImg.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            emptyViewImg.heightAnchor.constraint(equalToConstant: imgHeight)
        ]
        NSLayoutConstraint.activate(imgViewConstraints)
        return emptyViewImg
    }
    
    func createEmptyViewLabel(_ emptyView: UIView, _ iconView: UIImageView, _ labelWidth: CGFloat, _ labelText: String, _ labelTopIndent: CGFloat) {
        let emptyViewLabel = UILabel()
        emptyView.addSubview(emptyViewLabel)
        emptyViewLabel.translatesAutoresizingMaskIntoConstraints = false
        let labelConstraints = [
            emptyViewLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor,constant: labelTopIndent),
            emptyViewLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyViewLabel.widthAnchor.constraint(equalToConstant: labelWidth)
        ]
        NSLayoutConstraint.activate(labelConstraints)
        emptyViewLabel.textAlignment = .center
        emptyViewLabel.numberOfLines = 0
        emptyViewLabel.font = UIFont.systemFont(ofSize: 20)
        emptyViewLabel.text = labelText
    }
}

