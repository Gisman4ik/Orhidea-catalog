import Foundation
import Moya
import Alamofire

enum NetworkService {
    case getCatalogData
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.npoint.io/")!
    }
    var path: String {
        switch self {
        case .getCatalogData:
            return "a037d16e0def2d076a91"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getCatalogData:
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    var parameters: [String: Any]? {
        var params = [String: Any]()
        switch self {
        default:
            return nil
        }
    }
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.prettyPrinted
        }
    }
    var task: Task {
        switch self {
        default:
            guard let params = parameters else {
                return .requestPlain
            }
            return .requestParameters(parameters: params, encoding: parameterEncoding)
        }
    }
}
