//___FILEHEADER___

import UIKit

extension UIView {
    
    func addBorder(_ color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
}
