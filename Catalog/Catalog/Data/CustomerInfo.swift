import Foundation
import RealmSwift

class CustomerInfo: Object {
    @objc dynamic var name = ""
    @objc dynamic var surName: String?
    @objc dynamic var tel = ""
    @objc dynamic var email: String?
    @objc dynamic var country = ""
    @objc dynamic var city = ""
    @objc dynamic var address: String?
    @objc dynamic var apartmentNum: String?
    @objc dynamic var postcode: String?
}
