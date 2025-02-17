import Foundation

enum NetworkIntegrationError: Error {
    case badURL
    case decodingError(Error)
    case requestError(NetworkRequestError)
    case notAuthenticated
    
    var deviceConnectivityError: Bool {
        if case .requestError(let error) = self {
            return error.deviceConnectivityError
        }
        return false
    }
}
