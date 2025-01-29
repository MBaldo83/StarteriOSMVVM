import Foundation
import Combine

protocol DecodingEndpointAsyncNetwork {
    func send<T: Decodable>(_ endpoint: Endpoint, decodeTo type: T.Type) async -> Result<T, NetworkIntegrationError>
}

protocol RequestBuilding {
    func buildRequest(from endpoint: Endpoint) -> URLRequest?
}

protocol DecodingAsyncNetwork {
    func send<T: Decodable>(_ request: URLRequest, decodeTo type: T.Type) async -> Result<T, NetworkIntegrationError>
}

class RequestBuilderDecodingAsyncNetwork: DecodingEndpointAsyncNetwork {
    private let requestBuilder: RequestBuilding
    private let networkLayer: DecodingAsyncNetwork

    init(requestBuilder: RequestBuilding, networkLayer: DecodingAsyncNetwork) {
        self.requestBuilder = requestBuilder
        self.networkLayer = networkLayer
    }

    func send<T: Decodable>(_ endpoint: Endpoint, decodeTo type: T.Type) async -> Result<T, NetworkIntegrationError> {
        guard let request = requestBuilder.buildRequest(from: endpoint) else {
            return .failure(.badURL)
        }
        
        return await networkLayer.send(request, decodeTo: type)
    }
}

