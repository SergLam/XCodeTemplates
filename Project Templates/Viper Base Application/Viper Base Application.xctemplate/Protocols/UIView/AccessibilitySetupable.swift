//___FILEHEADER___

import UIKit

protocol AccessibilitySetupable: class {
    
    func setupAccessibility()
}

extension UIView {
    
    func setAccessibility(_ identifier: String?, _ label: String?, _ hint: String?) {
        self.isUserInteractionEnabled = label != nil
        self.isAccessibilityElement = label != nil
        self.accessibilityIdentifier = identifier
        self.accessibilityLabel = label
        self.accessibilityHint = hint
    }
    
}
