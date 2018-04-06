import UIKit
import RTDebugKit
import TTWindowManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var debugService: DebugServiceProtocol!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = TTWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        window.rootViewController = storyboard.instantiateInitialViewController()
        
        let backendEndpointService = BackendEndpointService(handler: self, defaultAlias: "dev")
        backendEndpointService.addBackendEndpoint(alias: "dev", url: "https://localhost:8000/api")
        backendEndpointService.addBackendEndpoint(alias: "test", url: "https://sometestserver.com/api")
        //this methods renders its own window, so it should be called before window.makeKeyAndVisible
        backendEndpointService.decorateApplicationWindow()
        
        window.makeKeyAndVisible()
        
        let isDebug = true
        self.initDebugService(window, isDebug: isDebug, backendEndpointService: backendEndpointService)
        
        return true
    }
    
    private func initDebugService(_ window: TTWindow, isDebug: Bool, backendEndpointService: BackendEndpointService) {
        //Отдельно, чтобы window было инициализировано
        DispatchQueue.main.async {
            if isDebug {
                let debug = DebugService(window: window, backendEndpointService: backendEndpointService)
                DebugService.logger = BackgroundLogService(DebugLogService())
                debug.activate()
                self.debugService = debug
            } else {
                self.debugService = ReleaseDebugService()
                self.debugService.activate()
                ReleaseDebugService.logger = BackgroundLogService(LogzSentryLogService(logzioToken: "logzio_token", sentryDSN: "sentry_dsn"))
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: BackendEndpointHandlerProtocol {
    func resetBackendEndpoint() {
        //Add some reinitialization code here
        print("Reset backend endpoint")
    }
    
    func setBaseUrl(_ url: String) {
        //Set base url in your request class
        print("set base url \(url)")
    }
}
