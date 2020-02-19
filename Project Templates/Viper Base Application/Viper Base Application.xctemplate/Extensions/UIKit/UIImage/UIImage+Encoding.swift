//___FILEHEADER___

import UIKit

extension UIImage {
    
     func base64String() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }

}
