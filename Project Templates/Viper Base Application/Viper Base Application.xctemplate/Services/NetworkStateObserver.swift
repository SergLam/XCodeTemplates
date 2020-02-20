//___FILEHEADER___

import Foundation
import Reachability

extension NSNotification.Name {
    
    public static let LostConnection = Notification.Name("\(Bundle.main.bundleIdentifier ?? "").didLostConnection")
    public static let RestoreConnection = Notification.Name("\(Bundle.main.bundleIdentifier ?? "").didRestoreConnection")
}

class NetworkStateObserver: NSObject {
    
    static let shared = NetworkStateObserver()
    
    static let reachability = Reachability()!
    
    var isNetworkAvailable: Bool {
        return reachabilityStatus != .none
    }
    
    var reachabilityStatus: Reachability.Connection = reachability.connection
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: NetworkStateObserver.reachability)
        do{
            try NetworkStateObserver.reachability.startNotifier()
        } catch {
            preconditionFailure("Could not start reachability notifier")
        }
    }
    
    @objc
    func reachabilityChanged(notification: Notification) {
        guard let reachability = notification.object as? Reachability else {
            assert(false, "Unable to cast notification")
            return
        }
        switch reachability.connection {
        case .none:
            reachabilityStatus = .none
            NotificationCenter.default.post(name: NSNotification.Name.LostConnection, object: self, userInfo: nil)
            
        case .wifi, .cellular:
            reachabilityStatus = reachability.connection
            NotificationCenter.default.post(name: NSNotification.Name.RestoreConnection, object: self, userInfo: nil)
        }
    }
    
}
