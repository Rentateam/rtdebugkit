import UIKit
import FLEX
import TTWindowManager

public class DebugService: CommonDebugService, DebugServiceProtocol {
    private var window: TTWindow!
    static private var bgQueue = DispatchQueue.global(qos: .background)
    private var backendEndpointService: BackendEndpointService!
    
    public init(window: TTWindow!, backendEndpointService: BackendEndpointService) {
        self.backendEndpointService = backendEndpointService
        self.window = window
        super.init()
    }
    
    public func activate() {
        if CommonDebugService.isDebugServiceActive { return }
        CommonDebugService.isDebugServiceActive = true
        DebugService.bgQueue.async {
            FLEXManager.shared().isNetworkDebuggingEnabled = true
            self.window.shakeGestureCallback = {
                self.onShake()
            }
        }
    }
    
    private func onShake() -> Void {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(
            title: "Отмена",
            style: .cancel,
            handler: nil
        ))
        actionSheet.addAction(UIAlertAction(
            title: "Отладчик",
            style: .default,
            handler: {(alert: UIAlertAction!) in
                self.showDebugger()
        }
        ))
        actionSheet.addAction(UIAlertAction(
            title: "Переключение сервера",
            style: .default,
            handler: {(alert: UIAlertAction!) in
                self.showBackendSwitch()
        }
        ))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(
            actionSheet,
            animated: true
        )
    }
    
    private func showDebugger() -> Void {
        FLEXManager.shared().showExplorer()
    }
    
    private func showBackendSwitch() {
        let podBundle = Bundle(for: DebugService.self)
        let bundle = Bundle(url: podBundle.url(forResource: "RTDebugKit", withExtension: "bundle")!)!
        let storyboard = UIStoryboard(name: "BackendEndpointSelect", bundle: bundle)
        let backendEndpointController = storyboard.instantiateInitialViewController() as! BackendEndpointSelectController
        backendEndpointController.backendEndpointService = self.backendEndpointService
        let controller = UINavigationController(rootViewController: backendEndpointController)
        UIApplication.shared.keyWindow?.rootViewController?.present(
            controller,
            animated: true
        )
    }
}
