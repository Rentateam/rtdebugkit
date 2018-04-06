public protocol LogServiceProtocol {
    func logDebug(message: String, userInfo: [String: Any])
    func logInfo(message: String, userInfo: [String: Any])
    func logWarning(message: String, userInfo: [String: Any])
    func logError(message: String, userInfo: [String: Any])
}
