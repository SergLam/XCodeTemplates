//___FILEHEADER___

import Foundation
import UIKit
import UserNotifications

class ___FILEBASENAMEASIDENTIFIER___: NSObject {
    
    private func configure() {
        UNUserNotificationCenter.current().delegate = self
    }

    public func registerForRemoteNotifications() {
        configure()
        
        let application = UIApplication.shared
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) {_, _ in

        }

        application.registerForRemoteNotifications()
        
    }

    public func handleRemoteNotification(with userInfo: [AnyHashable: Any]) {
        
    }
    
    public func handleDeviceToken(token: Data) {
        let strToken = token.reduce("") { $0 + String(format: "%02.2hhx", $1) }
    }
}

extension ___FILEBASENAMEASIDENTIFIER___: UNUserNotificationCenterDelegate {

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
}
