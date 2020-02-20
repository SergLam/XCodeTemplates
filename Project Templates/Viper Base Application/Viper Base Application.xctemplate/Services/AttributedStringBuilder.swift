//___FILEHEADER___

import UIKit

final class AttributedStringBuilder {
    
    /**
     Returns an attributed string with a specified font, line height and text alignment
     */
    static func textWithLineHeight(_ text: String, _ font: UIFont, _ lineHeight: CGFloat) -> NSMutableAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight / font.pointSize
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        let attrString = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: attrString.length)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttribute(.font, value: font, range: range)
        return attrString
    }
    
    static func attributedString(_ text: String,
                                 _ font: UIFont,
                                 _ color: UIColor,
                                 _ lineHeight: CGFloat,
                                 _ characterSpacing: CGFloat) -> NSMutableAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight / font.pointSize
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        let attrString = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: attrString.length)
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttribute(.font, value: font, range: range)
        attrString.addAttribute(.foregroundColor, value: color, range: range)
        attrString.addAttribute(.kern, value: characterSpacing, range: range)
        return attrString
    }
    
}
