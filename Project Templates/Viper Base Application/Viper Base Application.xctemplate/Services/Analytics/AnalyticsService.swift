//___FILEHEADER___

import FBSDKCoreKit
import FirebaseAnalytics
import Foundation

final class AnalyticsService: NSObject {
    
    // MARK: - Log event
    static func log(_ event: AnalyticsEvents) {
        
        let parameters: [String: Any] = [:]
        Analytics.logEvent(event.rawValue, parameters: parameters)
        AppEvents.logEvent(AppEvents.Name(rawValue: event.rawValue), parameters: parameters)
    }
    
}
