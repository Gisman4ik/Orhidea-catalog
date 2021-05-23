import Foundation

final class DataManager {
    static let shared = DataManager()
    
    var catalogData: CatalogData?
    var filteredCatalogProducts: [Product] = []
    var favoriteProducts: [Product] = []
    private init() {}
}
