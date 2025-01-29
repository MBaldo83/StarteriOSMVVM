import Foundation

protocol AsyncNetworkLayer {
    func send(_ request: URLRequest) async -> Result<Data, NetworkRequestError>
}
