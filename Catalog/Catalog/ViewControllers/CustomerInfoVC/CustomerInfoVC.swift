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
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupFields()
        setNavBarAppearance()
    }
    override func viewDidAppear(_ animated: Bool) {
        nameField.becomeFirstResponder()
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
        setNavBarWithSubTitle(step: "1")
    }
    
    @objc func nextBarButtonAction() {
        guard let name = nameField.text, !name.isEmpty else {
            nameField.borderActiveColor = .red
            nameField.borderInactiveColor = .red
            return
            
        }
        guard let tel = telField.text, !tel.isEmpty else {
            telField.borderActiveColor = .red
            telField.borderInactiveColor = .red
            return
        }
        pushViewController(controller: DeliveryInfoVC.self)
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
        guard let textField = textField as? HoshiTextField else {return}
        textField.borderActiveColor = UIColor(named: "CatalogBlueColor")
        textField.borderInactiveColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
}


