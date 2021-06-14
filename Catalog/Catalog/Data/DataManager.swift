import Foundation

final class DataManager {
    static let shared = DataManager()
    
    var catalogData: CatalogData?
    var filteredCatalogProducts: [Product] = []
    var favoriteProducts: [Product] = []
    var cartProducts: [Product] = []
    var deliveryCountries = ["Другая (указать свою)","Беларусь","Россия","Украина","Казахстан"]
    
    private  init() {}
}
