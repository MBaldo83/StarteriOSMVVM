import Foundation

enum NetworkRequestError: Error {
    
    case unexpectedResponse
    case unexpectedStatusCode(Int)
    case networkTransportError(Error)
    
    var deviceConnectivityError: Bool {
        if case .networkTransportError(_) = self {
            return true
        }
        return false
    }
}
