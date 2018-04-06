import Foundation
import JustLog
import Sentry

public class LogzSentryLogService: LogServiceProtocol {
    
    private var sentryClient: Client?
    private var logzioLogger: Logger?
    
    public init(logzioToken: String?, sentryDSN: String?) {
        if logzioToken != nil {
            let logger = Logger.shared
            logger.logzioToken = logzioToken!
            logger.logstashHost = "listener.logz.io"
            logger.logstashPort = 5052
            logger.setup()
            self.logzioLogger = logger
        }
        
        if sentryDSN != nil {
            self.sentryClient = try! Client(dsn: sentryDSN!)
        }
    }
    
    public func logDebug(message: String, userInfo: [String : Any]) {
        self.logzioLogger?.debug(message, error: nil, userInfo: userInfo)
    }
    
    public func logInfo(message: String, userInfo: [String : Any]) {
        self.logzioLogger?.info(message, error: nil, userInfo: userInfo)
    }
    
    public func logWarning(message: String, userInfo: [String : Any]) {
        self.logzioLogger?.warning(message, error: nil, userInfo: userInfo)
        let event = Event(level: .warning)
        event.message = message
        event.extra = userInfo
        self.sentryClient?.send(event: event, completion: nil)
    }
    
    public func logError(message: String, userInfo: [String : Any]) {
        self.logzioLogger?.error(message, error: nil, userInfo: userInfo)
        let event = Event(level: .error)
        event.message = message
        event.extra = userInfo
        self.sentryClient?.send(event: event, completion: nil)
    }
}
