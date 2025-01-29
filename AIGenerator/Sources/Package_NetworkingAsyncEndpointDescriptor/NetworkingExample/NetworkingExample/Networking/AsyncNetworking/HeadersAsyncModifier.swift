import Foundation

// MARK: Header Modifier

extension DecodingAsyncNetwork {
    func addHeaders(
        _ headers: [String: String]
    ) -> some DecodingAsyncNetwork {
        modified(HeadersAsyncModifier(headers: headers))
    }
}

struct HeadersAsyncModifier: AsyncNetworkingModifier {
    
    private var headers: [String: String]

    init(headers: [String: String]) {
        self.headers = headers
    }
    
    func send<T: Decodable>(request: URLRequest, upstream: some DecodingAsyncNetwork, decodeTo type: T.Type) async -> Result<T, NetworkIntegrationError> {
        var modifiedRequest = request
        for (key, value) in headers {
            modifiedRequest.setValue(value, forHTTPHeaderField: key)
        }
        return await upstream.send(modifiedRequest, decodeTo: type)
    }
}
