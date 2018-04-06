public class DebugLogService: LogServiceProtocol {
    public init() {
        
    }
    
    public func logDebug(message: String, userInfo: [String : Any]) {
        print("Debug: \(message), userInfo: \(userInfo as NSDictionary)")
    }
    
    public func logInfo(message: String, userInfo: [String : Any]) {
        print("Info: \(message), userInfo: \(userInfo as NSDictionary)")
    }
    
    public func logWarning(message: String, userInfo: [String : Any]) {
        print("Warning: \(message), userInfo: \(userInfo as NSDictionary)")
    }
    
    public func logError(message: String, userInfo: [String : Any]) {
        print("Error: \(message), userInfo: \(userInfo as NSDictionary)")
    }
}
