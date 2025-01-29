import Foundation

protocol AsyncNetworkingModifier {
    func send<T: Decodable>(request: URLRequest, upstream: some DecodingAsyncNetwork, decodeTo type: T.Type) async -> Result<T, NetworkIntegrationError>
}

extension DecodingAsyncNetwork {
  /// Modify the upstream decoding networking component using a networking modifier.
  public func modified(_ modifier: some AsyncNetworkingModifier) -> some DecodingAsyncNetwork {
      Modified(upstream: self, modifier: modifier)
  }
}

private struct Modified<Upstream: DecodingAsyncNetwork, Modifier: AsyncNetworkingModifier> {
  let upstream: Upstream
  let modifier: Modifier
}

extension Modified: DecodingAsyncNetwork {
    func send<T: Decodable>(_ request: URLRequest, decodeTo type: T.Type) async -> Result<T, NetworkIntegrationError> {
        await modifier.send(request: request, upstream: upstream, decodeTo: type)
    }
}
