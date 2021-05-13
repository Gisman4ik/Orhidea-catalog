//
//  PreLoadVC.swift
//  Catalog
//
//  Created by Artur Radziukhin on 5.05.21.
//

import UIKit

class PreLoadVC: UIViewController {
    
    var catalogData: CatalogData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCatalogData()
        
    }
    func getCatalogData() {
        NetworkManager.shared.getCatalogData { (result) in
            self.catalogData = result
            guard let catalogVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: CatalogVC.self)) as? CatalogVC else {
                return
            }
            catalogVC.catalogData = self.catalogData
            self.navigationController?.pushViewController(catalogVC, animated: true)
        } failure: { (error) in
            print(error)
        }
        
    }
}
