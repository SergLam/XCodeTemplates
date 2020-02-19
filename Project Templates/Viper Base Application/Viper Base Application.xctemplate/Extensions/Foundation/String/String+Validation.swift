//___FILEHEADER___

import Foundation

extension String {
    
    var containsOnlyEmoji: Bool {
        return !isEmpty && !unicodeScalars.contains(where: { !$0.isEmoji && !$0.isZeroWidthJoiner })
    }
    
    func fixUrlString() -> String {
        guard self.hasPrefix("http://") && self.hasPrefix("https://") else {
            return "https://\(self)"
        }
        return self
    }
    
    func isValidURL() -> Bool {
        let urlRegEx = "((https?://(?:www\\.|(?!www)))|(www\\.))((?!-)[a-zA-Z0-9-]{1,64}(?<!-))\\.?((?:[a-zA-Z0-9]{2,})?(?:\\.[a-zA-Z0-9]{2,})?)+[\\w-\\._~:/?#\\[\\]@!\\$&'\\(\\)\\*\\+,;=.]+"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
    
    func findURLs() -> [URL] {
        
        do {
             let urlRegEx = "((https?://(?:www\\.|(?!www)))|(www\\.))((?!-)[a-zA-Z0-9-]{1,64}(?<!-))\\.?((?:[a-zA-Z0-9]{2,})?(?:\\.[a-zA-Z0-9]{2,})?)+[\\w-\\._~:/?#\\[\\]@!\\$&'\\(\\)\\*\\+,;=.]+"
            let regEx = try NSRegularExpression(pattern: urlRegEx, options: .caseInsensitive)
            let matches = regEx.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            
            var resultArray: [URL] = []
            for match in matches {
                
                var linkString = self[match.range.lowerBound..<match.range.upperBound]
                if !linkString.hasPrefix("http://") && !linkString.hasPrefix("https://") {
                    linkString = "http://\(linkString)"
                }
                if let url = URL(string: linkString) {
                    resultArray.append(url)
                }
            }
            return resultArray
            
        } catch {
            let message: String = "Unable to create regular expression"
            ErrorLoggerService.logWithTrace(message)
            return []
        }
    }
    
}
