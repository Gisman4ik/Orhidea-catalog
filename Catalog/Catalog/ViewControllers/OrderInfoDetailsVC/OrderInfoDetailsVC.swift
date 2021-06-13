import UIKit

class OrderInfoDetailsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setNavBarAppearance()
    }
    func setNavBarAppearance() {
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(backBarButtonAction))
        //backButton.tintColor = UIColor.black
        backButton.image = UIImage(systemName: "arrow.left")
        navigationItem.leftBarButtonItem = backButton
        self.navigationItem.titleView = setTitle(title: "Оформление заказа", titleColor: UIColor.black, titleSize: 16, subtitle: "Шаг 3 из 3", subtitleColor: UIColor.gray, subtitleSize: 12, view: self.view)
    }
    @objc func backBarButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}
