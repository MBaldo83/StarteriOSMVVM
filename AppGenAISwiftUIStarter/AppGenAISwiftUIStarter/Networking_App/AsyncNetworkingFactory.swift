import Foundation

class AsyncNetworkingFactory {
    func networkLayer(
        baseURLProvider: @escaping () -> URL?
    ) -> DecodingEndpointAsyncNetwork {
        
        RequestBuilderDecodingAsyncNetwork(
            requestBuilder: RequestBuilder(
                baseURL: baseURLProvider
            ),
            networkLayer: JSONDecodingAsyncNetwork(
                wrapping: URLSessionAsyncNetworkLayer()
            )
        )
    }
}
