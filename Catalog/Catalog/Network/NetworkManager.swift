import Foundation
import Moya
import Moya_ObjectMapper

final class NetworkManager {
    private let provider = MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin()])
    private init() {}
    
    static let shared = NetworkManager()
    
    func getCatalogData(completion: @escaping (CatalogData) -> Void, failure: @escaping (String) -> Void) {
        provider.request(.getCatalogData) { (result) in
            switch result {
            case let .success(response):
                guard let catalogData = try? response.mapObject(CatalogData.self) else {
                    failure("Unknown")
                    return
                }
                completion(catalogData)
            case let .failure(error):
                failure(error.errorDescription ?? "Unknown")
            }
        }
    }
}
