import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    
    let realm = try! Realm()
    
    func addToFavorites(_ product: Product) {
        let productID = RealmWrapperFavoriteID()
        productID.uid = product.uid
        try! realm.write{
            realm.add(productID)
        }
    }
    
    func readFromFavorites () -> [String]{
        try! realm.write{
            return Array(realm.objects(RealmWrapperFavoriteID.self)).map { productID in
                return productID.uid
            }
        }
    }
    
    func deleteFromFavorites(_ product: Product) {
        try! realm.write{
            let obj = realm.object(ofType: RealmWrapperFavoriteID.self, forPrimaryKey: product.uid)
            guard let objForDelete = obj else {return}
            realm.delete(objForDelete)
        }
    }
    
    func addToCart(_ product: Product, amount: Int) {
        let productID = RealmWrapperCartID()
        productID.uid = product.uid
        productID.amount = amount
        try! realm.write{
            realm.add(productID)
        }
    }
    
    func readFromCart () -> [RealmWrapperCartID]{
        try! realm.write{
            return Array(realm.objects(RealmWrapperCartID.self))
        }
    }
    
    func updateCartItemAmount(uid: String?, amount: Int?) {
        guard let uid = uid, let amount = amount else {return}
        try! realm.write{
           let item = realm.object(ofType: RealmWrapperCartID.self, forPrimaryKey: uid)
            item?.amount = amount
        }
    }
    
    func deleteFromCart(_ product: Product) {
        try! realm.write{
            let obj = realm.object(ofType: RealmWrapperCartID.self, forPrimaryKey: product.uid)
            guard let objForDelete = obj else {return}
            realm.delete(objForDelete)
        }
    }
    
    func readCustomerSave() -> CustomerInfo? {
        try! realm.write{
            let save =  realm.objects(CustomerInfo.self).first
            return save
        }
    }
    
    func createCustomerSave() {
        try! realm.write{
            realm.add(CustomerInfo())
        }
    }
    
    private init() {}
}
