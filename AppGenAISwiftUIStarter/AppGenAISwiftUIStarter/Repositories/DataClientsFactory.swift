import Foundation

class DataClientsFactory {
    
    let networkingFactory: AsyncNetworkingFactory
    
    init(networkingFactory: AsyncNetworkingFactory) {
        self.networkingFactory = networkingFactory
    }
    
    func getCafeProductsClient() -> CafeProductsClient {
        NetworkingCafeProductsClient(
            networking: networkingFactory.networkLayer(
                baseURLProvider: { URL(string: "http://localhost:8001") }
            )
        )
    }
}
