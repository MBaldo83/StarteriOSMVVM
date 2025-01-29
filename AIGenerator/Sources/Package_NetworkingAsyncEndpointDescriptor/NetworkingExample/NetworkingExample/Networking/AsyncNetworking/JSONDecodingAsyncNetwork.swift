import Foundation

class JSONDecodingAsyncNetwork {
    private let wrapped: AsyncNetworkLayer
    
    init(wrapping networkLayer: AsyncNetworkLayer) {
        self.wrapped = networkLayer
    }
}

extension JSONDecodingAsyncNetwork: DecodingAsyncNetwork {
    
    func send<T: Decodable>(_ request: URLRequest, decodeTo type: T.Type) async -> Result<T, NetworkIntegrationError> {
        let result = await wrapped.send(request)
        
        switch result {
        case .success(let data):
            do {
                let decoder = JSONDecoder()
                let decodedObject = try decoder.decode(T.self, from: data)
                return .success(decodedObject)
            } catch {
                return .failure(.decodingError(error))
            }
        case .failure(let error):
            return .failure(.requestError(error))
        }
    }
}
