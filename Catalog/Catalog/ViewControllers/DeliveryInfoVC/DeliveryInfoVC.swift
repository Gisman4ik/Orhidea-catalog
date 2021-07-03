//
//  DeliveryInfoVC.swift
//  Catalog
//
//  Created by Artur Radziukhin on 13.06.21.
//

import UIKit
import TextFieldEffects

class DeliveryInfoVC: UIViewController  {
    
    @IBOutlet weak var countryField: HoshiTextField!
    @IBOutlet weak var cityField: HoshiTextField!
    @IBOutlet weak var addressField: HoshiTextField!
    @IBOutlet weak var apartNumField: HoshiTextField!
    @IBOutlet weak var postcodeField: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        setupFields()
        setNavBarAppearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countryField.becomeFirstResponder()
    }
    
    func setupFields() {
        let font = UIFont(name: "ArialMT", size: 18)
        countryField.font = font
        cityField.font = font
        addressField.font = font
        apartNumField.font = font
        postcodeField.font = font
        setCountryPicker()
        guard let customerSave = RealmManager.shared.readCustomerSave() else {return}
        countryField.text = customerSave.country
        cityField.text = customerSave.city
        addressField.text = customerSave.address
        apartNumField.text = customerSave.apartmentNum
        postcodeField.text = customerSave.postcode
    }

    func setCountryPicker() {
        let countryPicker = UIPickerView()
        countryPicker.delegate = self
        countryPicker.dataSource = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(named: "CatalogBlueColor")
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePickerAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPickerAction))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        countryField.inputAccessoryView = toolBar
        countryField.inputView = countryPicker
    }

    @objc func cancelPickerAction() {
        countryField.text = ""
        view.endEditing(true)
    }

    @objc func donePickerAction() {
        if (countryField.text ?? "").isEmpty{
            view.endEditing(true)
            countryField.inputView = nil
            countryField.becomeFirstResponder()
        }
        else {
            view.endEditing(true)
        }
    }

    func setNavBarAppearance() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Далее", style: .plain, target: self, action: #selector(nextBarButtonAction))
        setNavBarWithSubTitle(step: "2")
    }
    
    @objc func nextBarButtonAction() {        guard let country = countryField.text, !country.isEmpty else {
            countryField.borderActiveColor = .red
            countryField.borderInactiveColor = .red
            return
        }
        guard let city = cityField.text, !city.isEmpty else {
                cityField.borderActiveColor = .red
                cityField.borderInactiveColor = .red
                return
        }
        pushViewController(controller: OrderInfoDetailsVC.self)
    }
}

extension DeliveryInfoVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let customerSave = RealmManager.shared.readCustomerSave()
        try! RealmManager.shared.realm.write{
            customerSave?.country = countryField.text ?? ""
            customerSave?.city = cityField.text ?? ""
            customerSave?.address = addressField.text ?? ""
            customerSave?.apartmentNum = apartNumField.text ?? ""
            customerSave?.postcode = postcodeField.text ?? ""
        }
        if textField == countryField {
            setCountryPicker()
        }
        guard let textField = textField as? HoshiTextField else {return}
        textField.borderActiveColor = UIColor(named: "CatalogBlueColor")
        textField.borderInactiveColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
}

extension DeliveryInfoVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        DataManager.shared.deliveryCountries.count
    }
}
extension DeliveryInfoVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        DataManager.shared.deliveryCountries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if DataManager.shared.deliveryCountries[row] == "Другая (указать свою)" {
            countryField.text = ""
        } else {
            countryField.text = DataManager.shared.deliveryCountries[row]
        }
    }
}
