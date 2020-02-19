//___FILEHEADER___

import UIKit

extension NSMutableAttributedString {
    
    /**
     Returns attributed string with colored substrings with new line separation
     */
    static func coloredStrings(strings: [String], colors: [UIColor], font: UIFont) -> NSMutableAttributedString {
        
        assert(strings.count == colors.count, "strings count should be equal to colors count")
        
        let resultString = strings.joined()
        
        let result = NSMutableAttributedString(string: resultString, attributes: [NSAttributedString.Key.font: font])
        var currentStringLocation = 0
        
        for (index, string) in strings.enumerated() {
            result.addAttribute(NSAttributedString.Key.foregroundColor, value: colors[index], range: NSRange(location: currentStringLocation, length: string.count) )
            currentStringLocation += string.count
        }
        
        return result
    }
}
