import Alamofire
import AlamofireActivityLogger

public class CommonDebugService {
    
    static var isDebugServiceActive = false
    static public var logger: BackgroundLogService!
    
    public init() {
        
    }

    fileprivate struct BackgroundPrinter: Printer {
        public init() {}
        
        public func print(_ string: String, phase: Phase) {
            CommonDebugService.printDebug(string, [:])
        }
    }
    
    static public func logNetworkRequest(request: DataRequest) -> DataRequest {
        if !CommonDebugService.isDebugServiceActive {
            return request
        } else {
            return request.log(level: .info,
                               options: [],
                               printer: BackgroundPrinter())
        }
    }
    
    private static func appendAdditionalInfo(userInfo: [String: Any]) -> [String: Any] {
        return [:]
    }
    
    public static func printDebug(_ message: String, _ userInfo: [String: Any]) {
        if !CommonDebugService.isDebugServiceActive { return }
        
        CommonDebugService.logger?.printInBackground(level: .debug, message: message, userInfo: CommonDebugService.appendAdditionalInfo(userInfo: userInfo))
    }
    
    public static func printInfo(_ message: String, _ userInfo: [String: Any]) {
        if !CommonDebugService.isDebugServiceActive { return }
        
        CommonDebugService.logger?.printInBackground(level: .info, message: message, userInfo: CommonDebugService.appendAdditionalInfo(userInfo: userInfo))
    }
    
    public static func printWarning(_ message: String, _ userInfo: [String: Any]) {
        if !CommonDebugService.isDebugServiceActive { return }
        
        CommonDebugService.logger?.printInBackground(level: .warning, message: message, userInfo: CommonDebugService.appendAdditionalInfo(userInfo: userInfo))
    }
    
    public static func printError(_ message: String, _ userInfo: [String: Any]) {
        if !CommonDebugService.isDebugServiceActive { return }
        
        CommonDebugService.logger?.printInBackground(level: .error, message: message, userInfo: CommonDebugService.appendAdditionalInfo(userInfo: userInfo))
    }
    
    public static func printInfo(_ message: String) {
        CommonDebugService.printInfo(message, [:])
    }
    
    public static func printWarning(_ message: String) {
        CommonDebugService.printWarning(message, [:])
    }
    
    public static func printError(_ message: String) {
        CommonDebugService.printError(message, [:])
    }
    
    public static func printDebug(_ message: String) {
        CommonDebugService.printDebug(message, [:])
    }
}
