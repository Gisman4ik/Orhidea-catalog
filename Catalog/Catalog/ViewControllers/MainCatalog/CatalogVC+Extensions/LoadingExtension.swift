import UIKit

extension CatalogVC {
    func setLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.backgroundColor = #colorLiteral(red: 0.9763647914, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        view.addSubview(loadingView)
        let margins = view.safeAreaLayoutGuide
        let viewConstraints = [
            loadingView.topAnchor.constraint(equalTo: margins.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            loadingView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ]
        NSLayoutConstraint.activate(viewConstraints)
        
        let logoImg = UIImage(named: "LogoDressesBlack.png")
        let logoImgView = UIImageView(image: logoImg)
        logoImgView.contentMode = .scaleAspectFit
        loadingView.addSubview(logoImgView)
        logoImgView.translatesAutoresizingMaskIntoConstraints = false
        let imgViewConstraints = [
            logoImgView.topAnchor.constraint(equalTo: loadingView.topAnchor),
            logoImgView.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor),
            logoImgView.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor),
            logoImgView.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(imgViewConstraints)
    }
}
