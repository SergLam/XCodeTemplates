//___FILEHEADER___

import Kingfisher
import UIKit

extension UIButton {
    
    func setImageFromURL(_ imageURL: String) {
        
        let url = URL(string: imageURL)
        self.adjustsImageWhenHighlighted = false
        kf.setImage(with: url, for: .normal)
    }
    
}
