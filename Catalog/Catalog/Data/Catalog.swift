import Foundation
import ObjectMapper
import RealmSwift

class CatalogData: Mappable {
    var total = 0
    var products: [Product] = []
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        total <- map["total"]
        products <- map["products"]
    }
}

class Product: Mappable {
    var uid = ""
    var title: String?
    var sku = ""
    var text = ""
    var quantity = ""
    var color: String?
    var price: String?
    var sizeChart: String?
    var minSize = ""
    var maxSize = ""
    var sort = ""
    var url = ""
    var imageURLString: String?
    var gallery = ""
    var amountInCart: Int?
    var isInFavorite = false
    var isInCart = false

    func addToFavorite() {
        isInFavorite = true
        RealmManager.shared.addToFavorites(self)
        DataManager.shared.favoriteProducts.append(self)
    }
    
    func removeFromFavorite() {
        isInFavorite = false
        RealmManager.shared.deleteFromFavorites(self)
        DataManager.shared.favoriteProducts = DataManager.shared.favoriteProducts.filter{ $0.uid != self.uid }
    }
    
    func addToCart(amount: Int) {
        isInCart = true
        RealmManager.shared.addToCart(self, amount: amount)
        self.amountInCart = amount
        DataManager.shared.cartProducts.append(self)
    }
    
    func removeFromCart() {
        isInCart = false
        self.amountInCart = nil
        RealmManager.shared.deleteFromCart(self)
        DataManager.shared.cartProducts = DataManager.shared.cartProducts.filter{ $0.uid != self.uid }
    }
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        title           <- map["title"]
        price           <- map["price"]
        text            <- map["text"]
        quantity        <- map["quantity"]
        imageURLString  <- map["editions.0.img"]
        color           <- map["editions.0.Цвет"]
        sizeChart       <- map["descr"]
        url             <- map["url"]
        uid             <- map["uid"]
        sku             <- map["sku"]
        sort            <- map["sort"]
        gallery         <- map["gallery"]
    }
    
    func extractMinMaxSizes() -> [Int]{
        let range = sizeChart?.range(of: "[0-9][0-9]-[0-9][0-9]", options: .regularExpression)
        guard let rangeOfSizes = range else {return []}
        let sizesArr = sizeChart?[rangeOfSizes].split(separator: "-")
        guard let sizes = sizesArr, let intMinSize = Int((sizes[0])), let intMaxSize = Int(sizes[1]) else {return []}
        return [intMinSize,intMaxSize]
    }
}

class Gallery: Mappable {
    var images = ""
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        images <- map["img\\"]
    }
}

class RealmWrapperFavoriteID: Object {
    @objc dynamic var uid = ""
    
    override static func primaryKey() -> String? {
        return "uid"
    }
}
class RealmWrapperCartID: Object {
    @objc dynamic var uid = ""
    @objc dynamic var amount = 1
    
    override static func primaryKey() -> String? {
        return "uid"
    }
}
