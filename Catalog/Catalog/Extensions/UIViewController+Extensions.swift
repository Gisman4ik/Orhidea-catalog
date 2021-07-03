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

extension UIViewController {
    func setTitle(title: String, titleColor: UIColor, titleSize: Int, subtitle: String, subtitleColor: UIColor, subtitleSize: Int , view: UIView) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -5, width: (view.frame.width / 2) + (view.frame.width * 0.22), height: 20))
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = titleColor
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(titleSize))
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textAlignment = .center
        titleLabel.text = title
        
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: (view.frame.width / 2) + (view.frame.width * 0.22), height: 10))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = subtitleColor
        subtitleLabel.adjustsFontSizeToFitWidth = false
        subtitleLabel.lineBreakMode = .byTruncatingTail
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.systemFont(ofSize: CGFloat(subtitleSize))
        subtitleLabel.text = subtitle
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 30, height: 30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        return titleView
    }
    
    func setNavBarWithSubTitle(step: String) {
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(backStyledBarButtonAction))
        backButton.image = UIImage(systemName: "arrow.left")
        navigationItem.leftBarButtonItem = backButton
        self.navigationItem.titleView = setTitle(title: "Оформление заказа", titleColor: UIColor.black, titleSize: 16, subtitle: "Шаг \(step) из 3", subtitleColor: UIColor.gray, subtitleSize: 12, view: self.view)
    }
    
    @objc func backStyledBarButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}

extension UIViewController {
    func pushViewController<T>(controller: T) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: controller.self)) as? UIViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIViewController: UIGestureRecognizerDelegate {
}
