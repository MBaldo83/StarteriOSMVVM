import Foundation

// MARK: Identity Modifier

//struct IdentityAsyncModifier: AsyncNetworkingModifier {
//    
//    private let identity: Identity
//
//    init(identity: Identity) {
//        self.identity = identity
//    }
//    
//    func send<T: Decodable>(request: URLRequest, upstream: some DecodingAsyncNetwork, decodeTo type: T.Type) async -> Result<T, NetworkIntegrationError> {
//        
//        guard let accessToken = await identity.currentAccessToken() else {
//            return .failure(.notAuthenticated)
//        }
//        
//        var modifiedRequest = request
//        modifiedRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        
//        return await upstream.send(modifiedRequest, decodeTo: type)
//    }
//}
//
//extension DecodingAsyncNetwork {
//    func addIdentity(_ identity: Identity) -> some DecodingAsyncNetwork {
//        modified(IdentityAsyncModifier(identity: identity))
//    }
//}
