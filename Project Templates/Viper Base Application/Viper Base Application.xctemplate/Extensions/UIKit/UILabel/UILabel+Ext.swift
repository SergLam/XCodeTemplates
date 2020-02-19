//___FILEHEADER___

import UIKit

extension UILabel {
    
    /**
     Get max number of lines can be displayed in a label with constrained bounds.
     Use this property after assigning text to label.
     */
    func numberOfVisibleLines(fit viewWidth: CGFloat) -> Int {
        
        let maxSize = CGSize(width: viewWidth, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
    
}
