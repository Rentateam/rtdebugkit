public class BackgroundLogService {
    public enum LogLevel {
        case debug, info, warning, error
    }
    private var bgQueue = DispatchQueue.global(qos: .background)
    private var logService: LogServiceProtocol
    
    public init(_ logService: LogServiceProtocol) {
        self.logService = logService
    }
    
    public func printInBackground(level: LogLevel, message: String, userInfo: [String : Any]) {
        self.bgQueue.async {
            switch level {
            case .debug:
                self.logService.logDebug(message: message, userInfo: userInfo)
                break
            case .info:
                self.logService.logInfo(message: message, userInfo: userInfo)
                break
            case .warning:
                self.logService.logWarning(message: message, userInfo: userInfo)
                break
            case .error:
                self.logService.logError(message: message, userInfo: userInfo)
                break
            }
            
        }
    }
}
