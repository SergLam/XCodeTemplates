//___FILEHEADER___

import UIKit

final class URLExecutor {
    
    static func handleURL(_ url: URL, fallbackURL: URL?) {
        
        guard UIApplication.shared.canOpenURL(url) else {
            // Open App Store if app not available
            guard let appURL = fallbackURL else {
                assertionFailure("Unable to create url")
                return
            }
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
