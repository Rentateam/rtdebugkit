import Foundation

public protocol BackendEndpointHandlerProtocol {
    func resetBackendEndpoint()
    func setBaseUrl(_ url: String)
}
