import UIKit
import TextFieldEffects

class CustomerInfoVC: UIViewController {

    @IBOutlet weak var nameField: HoshiTextField!
    @IBOutlet weak var surNameField: HoshiTextField!
    @IBOutlet weak var telField: HoshiTextField!
    @IBOutlet weak var emailField: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkExistingCustomerSave()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupFields()
        setNavBarAppearance()
    }
    
    @objc func nextBarButtonAction() {
        guard let deliveryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DeliveryInfoVC.self)) as? DeliveryInfoVC else {return}
        navigationController?.pushViewController(deliveryVC, animated: true)
    }
    @objc func backBarButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    func checkExistingCustomerSave() {
        let save =  RealmManager.shared.readCustomerSave()
        if save == nil {
            RealmManager.shared.createCustomerSave()
        }
    }
    func setupFields() {
        let font = UIFont(name: "ArialMT", size: 18)
        nameField.font = font
        surNameField.font = font
        telField.font = font
        emailField.font = font
        guard let customerSave = RealmManager.shared.readCustomerSave() else {return}
        nameField.text = customerSave.name
        surNameField.text = customerSave.surName
        telField.text = customerSave.tel
        emailField.text = customerSave.email
    }
    func setNavBarAppearance() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Далее", style: .plain, target: self, action: #selector(nextBarButtonAction))
        let backButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(backBarButtonAction))
        //backButton.tintColor = UIColor.black
        backButton.image = UIImage(systemName: "arrow.left")
        navigationItem.leftBarButtonItem = backButton
        self.navigationItem.titleView = setTitle(title: "Оформление заказа", titleColor: UIColor.black, titleSize: 16, subtitle: "Шаг 1 из 3", subtitleColor: UIColor.gray, subtitleSize: 12, view: self.view)
    }
    
}

extension CustomerInfoVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let customerSave = RealmManager.shared.readCustomerSave()
        try! RealmManager.shared.realm.write{
            customerSave?.name = nameField.text ?? ""
            customerSave?.surName = surNameField.text ?? ""
            customerSave?.tel = telField.text ?? ""
            customerSave?.email = emailField.text ?? ""
        }
    }
}

extension UIViewController {
    func setTitle(title: String, titleColor: UIColor, titleSize: Int, subtitle: String, subtitleColor: UIColor, subtitleSize: Int , view: UIView) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x:0, y:-5, width: (view.frame.width / 2) + (view.frame.width * 0.22), height: 20))
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = titleColor
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(titleSize))
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textAlignment = .center
        titleLabel.text = title
        
        let subtitleLabel = UILabel(frame: CGRect(x:0, y:18, width: (view.frame.width / 2) + (view.frame.width * 0.22), height: 10))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = subtitleColor
        subtitleLabel.adjustsFontSizeToFitWidth = false
        subtitleLabel.lineBreakMode = .byTruncatingTail
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.systemFont(ofSize: CGFloat(subtitleSize))
        subtitleLabel.text = subtitle
        
        let titleView = UIView(frame: CGRect(x:0, y:0, width: view.frame.width - 30, height:30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        return titleView
    }
}
