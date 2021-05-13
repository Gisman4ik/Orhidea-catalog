import Foundation
import ObjectMapper

class CatalogData: Mappable {
    var total = 0
    var products: [Product] = []
    
    required init?(map: Map) {
        mapping(map: map)
    }
    func mapping(map: Map) {
        total <- map["total"]
        products <- map["products"]
    }
}

class Product: Mappable {
    var title: String?
    var uid = ""
    var sku = ""
    var text = ""
    var quantity = ""
    var color = ""
    var price = ""
    var sizeChart = ""
    var sort = ""
    var url = ""
    var imageURLString: String?

    required init?(map: Map) {
        mapping(map: map)
    }
    func mapping(map: Map) {
        title       <- map["title"]
        price       <- map["sku"]
        text        <- map["text"]
        quantity    <- map["quantity"]
        imageURLString <- map["editions.0.img"]
        color       <- map["editions.0.Цвет"]
        sizeChart   <- map["descr"]
        url         <- map["url"]
        uid         <- map["uid"]
        sku         <- map["sku"]
        sort        <- map["sort"]
    }
}
