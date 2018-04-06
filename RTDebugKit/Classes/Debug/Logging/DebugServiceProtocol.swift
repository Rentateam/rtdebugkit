import Alamofire

public protocol DebugServiceProtocol {
    func activate()
    static func logNetworkRequest(request: DataRequest) -> DataRequest
    static func printDebug(_ message: String, _ userInfo: [String: Any])
    static func printInfo(_ message: String, _ userInfo: [String: Any])
    static func printWarning(_ message: String, _ userInfo: [String: Any])
    static func printError(_ message: String, _ userInfo: [String: Any])
    static func printInfo(_ message: String)
    static func printWarning(_ message: String)
    static func printError(_ message: String)
    static func printDebug(_ message: String)
}
