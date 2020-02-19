//___FILEHEADER___

import UIKit

extension UITextView {
    
    func highLightLinksInText(text: String,
                              textColor: UIColor,
                              textFont: UIFont,
                              links: [String: String],
                              linksColor: UIColor,
                              linksFont: UIFont) {
        
        let attributedString = NSMutableAttributedString(string: text,
                                                         attributes: [.font: textFont,
                                                                      .foregroundColor:
                                                            textColor])
        let nstext = text as NSString
        
        for (key, value) in links {
            let range = nstext.localizedStandardRange(of: value)
            attributedString.addAttributes( [.font: linksFont], range: range)
            attributedString.addAttribute(NSAttributedString.Key.link, value: key, range: range)
        }
        linkTextAttributes = [NSAttributedString.Key.foregroundColor: linksColor]
        attributedText = attributedString
    }
}
