import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    
    let realm = try! Realm()
    
    func addToFavorites(_ product: Product) {
        let productID = ProductIDForRealm()
        productID.uid = product.uid
        try! realm.write{
            realm.add(productID)
        }
    }
    func readFromFavorites () -> [String]{
        try! realm.write{
            return Array(realm.objects(ProductIDForRealm.self)).map { productID in
                return productID.uid
            }
        }
    }
    func deleteFromFavorites(_ product: Product) {
        try! realm.write{
            let obj = realm.object(ofType: ProductIDForRealm.self, forPrimaryKey: product.uid)
            guard let objForDelete = obj else {return}
            realm.delete(objForDelete)
        }
    }
    
    private init() {}
}
