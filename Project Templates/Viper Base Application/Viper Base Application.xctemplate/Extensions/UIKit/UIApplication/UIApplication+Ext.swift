//___FILEHEADER___

import UIKit
import UserNotifications

typealias NotificationStatusClosure = (_ isAllowed: Bool, _ isRestricted: Bool, _ shouldRequestPermission: Bool) -> Void

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    static func waitUntillAppBecomeActive() {
        
        var condition = true
        while condition {
            guard UIApplication.shared.applicationState == .active else {
                continue
            }
            condition = false
        }
    }
    
    static func didUserAlowNotifications(completion: @escaping NotificationStatusClosure) {
        
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { settings in
            
            switch settings.authorizationStatus {
                
            case .notDetermined:
                DispatchQueue.main.async{
                    completion(false, false, true)
                }
                
            case .denied:
                DispatchQueue.main.async{
                    completion(false, true, false)
                }
                
            case .authorized:
                DispatchQueue.main.async{
                    completion(true, false, false)
                }
                
            case .provisional:
                DispatchQueue.main.async{
                    completion(true, false, false)
                }
            @unknown default:
                let message: String = "Unknown authorizationStatus value"
                ErrorLoggerService.logWithTrace(message)
                DispatchQueue.main.async{
                    completion(false, false, false)
                }
            }
        })
    }
    
}
