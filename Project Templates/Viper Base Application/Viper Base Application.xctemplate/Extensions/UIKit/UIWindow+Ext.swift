//___FILEHEADER___

import UIKit

extension UIWindow {
    
    func dismiss() {
        isHidden = true

        if #available(iOS 13, *) {
            windowScene = nil
        }
    }
    
}
