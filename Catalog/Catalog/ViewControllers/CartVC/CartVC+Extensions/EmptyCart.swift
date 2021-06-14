import UIKit

extension CartVC {
    func setupEmptyCartView() {
        emptyCartView.translatesAutoresizingMaskIntoConstraints = false
        emptyCartView.backgroundColor = #colorLiteral(red: 0.9763647914, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        view.addSubview(emptyCartView)
        let margins = view.safeAreaLayoutGuide
        let viewConstraints = [
            emptyCartView.topAnchor.constraint(equalTo: margins.topAnchor),
            emptyCartView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            emptyCartView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            emptyCartView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ]
        NSLayoutConstraint.activate(viewConstraints)
        let iconView = createEmptyCartViewImg()
        createEmptyCartLabel(iconView: iconView)
        emptyCartView.isHidden = true
    }
    
    func createEmptyCartViewImg() -> UIImageView{
        let emptyCartIcon = UIImage(named: "shoppingBag.svg")
        let EmptyCartViewImg = UIImageView(image: emptyCartIcon)
        EmptyCartViewImg.contentMode = .scaleAspectFit
        emptyCartView.addSubview(EmptyCartViewImg)
        EmptyCartViewImg.translatesAutoresizingMaskIntoConstraints = false
        let imgViewConstraints = [
            EmptyCartViewImg.centerXAnchor.constraint(equalTo: emptyCartView.centerXAnchor),
            EmptyCartViewImg.centerYAnchor.constraint(equalTo: emptyCartView.centerYAnchor),
            EmptyCartViewImg.widthAnchor.constraint(equalToConstant: 200),
            EmptyCartViewImg.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(imgViewConstraints)
        return EmptyCartViewImg
    }
    
    func createEmptyCartLabel(iconView: UIImageView) {
        let emptyCartLabel = UILabel()
        emptyCartView.addSubview(emptyCartLabel)
        let margins = view.safeAreaLayoutGuide
        emptyCartLabel.translatesAutoresizingMaskIntoConstraints = false
        let labelConstraints = [
            emptyCartLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 20),
            emptyCartLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            emptyCartLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ]
        NSLayoutConstraint.activate(labelConstraints)
        emptyCartLabel.textAlignment = .center
        emptyCartLabel.attributedText = NSAttributedString(string: "Ваша корзина пуста:(", attributes: [.font: UIFont.boldSystemFont(ofSize: 24)])
    }
}
