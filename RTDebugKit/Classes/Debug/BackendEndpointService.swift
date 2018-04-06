import Foundation
import UIKit
public class BackendEndpointService {
    private static let backendEndpointKey = "BackendEndpoint"
    
    private var backendEndpointList: [String:String]
    private var currentAlias: String
    private var logoWindow: UIWindow?
    private var logo: UIImageView?
    private var versionLabel: UILabel?
    
    private var handler: BackendEndpointHandlerProtocol
    
    public init(handler: BackendEndpointHandlerProtocol, defaultAlias: String) {
        self.handler = handler
        var savedAlias = UserDefaults.standard.object(forKey: BackendEndpointService.backendEndpointKey)
        if savedAlias == nil {
            savedAlias = defaultAlias
            UserDefaults.standard.setValue(savedAlias, forKey: BackendEndpointService.backendEndpointKey)
            UserDefaults.standard.synchronize()
        }
        self.currentAlias = savedAlias! as! String
        self.backendEndpointList = [:]
    }
    
    public func addBackendEndpoint(alias: String, url: String) {
        self.backendEndpointList[alias] = url
        if alias == self.currentAlias {
            self.handler.setBaseUrl(url)
        }
    }
    
    public func setCurrentAlias(_ alias: String) {
        let needReinitialize = currentAlias != alias
        if needReinitialize {
            currentAlias = alias
            UserDefaults.standard.setValue(currentAlias, forKey: BackendEndpointService.backendEndpointKey)
            UserDefaults.standard.synchronize()
            self.resetBackendEndpoint()
        }
    }
    
    public func getCurrentAlias() -> String {
        return self.currentAlias
    }
    
    public func getCurrentBackendPoint() -> String {
        return self.backendEndpointList[self.currentAlias]!
    }
    
    private func resetBackendEndpoint() {
        self.refreshLogoImage()
        self.handler.resetBackendEndpoint()
    }
    
    public func getBackendEndpointList() -> [String:String] {
        return self.backendEndpointList
    }
    
    public func decorateApplicationWindow() {
        self.logo = UIImageView.init(frame: CGRect(x: 0, y: 17, width: 50, height: 50))
        self.logo!.alpha = 0.5
        
        let versLabel = UILabel.init(frame: CGRect(x: 0, y: 30, width: 50, height: 20))
        versLabel.textColor = UIColor(red: 0, green: 0, blue: 255/255.0, alpha: 0.7)
        versLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        versLabel.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
        versLabel.textAlignment = .center
        self.versionLabel = versLabel
        
        let logoW = UIWindow.init(frame: UIScreen.main.bounds)
        logoW.windowLevel = UIWindowLevelStatusBar
        logoW.rootViewController = UIViewController()
        logoW.addSubview(self.logo!)
        logoW.addSubview(versLabel)
        logoW.bringSubview(toFront: versLabel)
        logoW.isUserInteractionEnabled = false
        logoW.makeKeyAndVisible()
        self.logoWindow = logoW
        self.refreshLogoImage()
    }
    
    private func refreshLogoImage() {
        self.logo?.image = UIImage(named: String(format: "backend_endpoint_%@", self.currentAlias))
    }
}
