public class ReleaseDebugService: CommonDebugService, DebugServiceProtocol {
    public override init() {
        
    }
    
    public func activate() {
        if CommonDebugService.isDebugServiceActive { return }
        CommonDebugService.isDebugServiceActive = true
    }
}
