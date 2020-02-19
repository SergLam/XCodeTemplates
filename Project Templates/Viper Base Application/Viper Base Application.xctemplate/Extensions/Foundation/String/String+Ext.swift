//___FILEHEADER___

import UIKit

extension String {
    
    func replaceGifExtension() -> String {
        return self.replacingOccurrences(of: ".gif", with: "")
    }
    
    func replaceMp4Extension() -> String {
        return self.replacingOccurrences(of: ".mp4", with: "")
    }
    
    func replaceMp3Extension() -> String {
        return self.replacingOccurrences(of: ".mp3", with: "")
    }
    
    func replaceJpegExtension() -> String {
        return self.replacingOccurrences(of: ".jpeg", with: "")
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    // NOTE: User blocked - last word in error message - contact email address
    func getContactEmail() -> String {
        let words = self.split(separator: " ")
        return String(words.last ?? "info@superfy.co")
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}
