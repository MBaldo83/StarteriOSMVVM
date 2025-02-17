import Foundation

enum CafeProductsAPI: Endpoint {
    case getProducts(maxResults: Int? = nil)
    case getProductById(productId: Int)
    case updateProduct(productId: Int, product: DecodableCafeProduct)

    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        case .getProductById(let productId):
            return "/products/\(productId)"
        case .updateProduct(let productId, _):
            return "/products/\(productId)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        case .getProductById:
            return .get
        case .updateProduct:
            return .put
        }
    }

    var urlComponents: [String: String] {
        switch self {
        case .getProducts(let maxResults):
            var params: [String: String] = [:]
            if let maxResults {
                params["max_results"] = String(maxResults)
            }
            return params
        case .getProductById, .updateProduct:
            return [:]
        }
    }

    var headers: [String: String] {
        switch self {
        case .getProducts, .getProductById, .updateProduct:
            return [:]
        }
    }

    var httpBody: Data? {
        switch self {
        case .getProducts, .getProductById:
            return nil
        case .updateProduct(_, let product):
            let encoder = JSONEncoder()
            return try? encoder.encode(product)
        }
    }
}

extension CafeProductsAPI {

    struct DecodableCafeProduct: Codable {
        let id: Int
        let name: String
        let description: String
        let type: String // Using String for now, will convert later

        enum CodingKeys: String, CodingKey {
            case id, name, description, type
        }
    }
}
