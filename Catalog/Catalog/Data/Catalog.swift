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
    var sort = ""
    var url = ""
    var imageURLString: String?
    var gallery = ""
    var isInFavorite = false
    
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
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        title       <- map["title"]
        price       <- map["price"]
        text        <- map["text"]
        quantity    <- map["quantity"]
        imageURLString <- map["editions.0.img"]
        color       <- map["editions.0.Цвет"]
        sizeChart   <- map["descr"]
        url         <- map["url"]
        uid         <- map["uid"]
        sku         <- map["sku"]
        sort        <- map["sort"]
        gallery     <- map["gallery"]
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

class ProductIDForRealm: Object {
    @objc dynamic var uid = ""
    
    override static func primaryKey() -> String? {
       return "uid"
     }
}

