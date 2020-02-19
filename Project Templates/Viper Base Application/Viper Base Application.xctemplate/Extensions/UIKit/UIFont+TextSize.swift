//___FILEHEADER___

import UIKit

extension UIFont {
    
    func sizeOfString(string: String, constrainedToWidth width: Double) -> CGSize {
        
        let attributes = [NSAttributedString.Key.font: self]
        let attString = NSAttributedString(string: string, attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        let range: CFRange = CFRange(location: 0, length: 0)
        let maxSize: CGSize = CGSize(width: width, height: Double.greatestFiniteMagnitude)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, range, nil, maxSize, nil)
    }
    
}
