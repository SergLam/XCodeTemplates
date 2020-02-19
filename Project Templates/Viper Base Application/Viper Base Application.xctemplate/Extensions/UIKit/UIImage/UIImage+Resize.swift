//___FILEHEADER___

import UIKit

extension UIImage {
    
    
    func resizedImage(newSize: CGSize) -> UIImage? {
        
        guard self.size != newSize else {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    class func resize(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio = targetSize.width / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    class func scale(image: UIImage, by scale: CGFloat) -> UIImage? {
        let size = image.size
        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        return UIImage.resize(image: image, targetSize: scaledSize)
    }
    
    /**
     Use for downscaling of images
     */
    func downSizeImage() -> UIImage? {
        
        var size: CGSize = CGSize.zero
        if self.size.width > self.size.height {
            size = ChatImageSize.landscape.preferredSize
        } else if self.size.width < self.size.height {
            size = ChatImageSize.portrait.preferredSize
        } else if self.size.width == self.size.height {
            size = ChatImageSize.square.preferredSize
        }
        
        guard let resizedImage = UIImage.resize(image: self, targetSize: size) else {
            let message: String = "Unable to resize image"
            ErrorLoggerService.logWithTrace(message)
            return nil
        }
        return resizedImage
    }
    
}
