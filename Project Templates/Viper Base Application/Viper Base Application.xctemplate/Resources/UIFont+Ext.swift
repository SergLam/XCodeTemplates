//___FILEHEADER___

import Rswift
import UIKit

private enum FontName: String, CaseIterable {
    
    case sfProDisplayRegular = "SFProDisplay-Regular"
    case sfProDisplayMedium = "SFProDisplay-Medium"
    case sfProDisplaySemibold = "SFProDisplay-Semibold"
    case sfProDisplayBold = "SFProDisplay-Bold"
    
    var errorMessage: String {
        switch self {
            return "Invalid font name / font file is missing / not registered in plist"
        }
    }
}

extension UIFont {
    
    // MARK: - SFProDisplay
    static var gifSFProDisplayRegular13: UIFont {
        
        guard let font = UIFont(name: FontName.sfProDisplayRegular.rawValue, size: 13.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 13.0, weight: .regular)
        }
        return font
    }
    
    static var gifSFProDisplayRegular15: UIFont {
        
        guard let font = UIFont(name: FontName.sfProDisplayRegular.rawValue, size: 15.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 15.0, weight: .regular)
        }
        return font
    }
    
    static var gifSFProDisplayRegular16: UIFont {
        
        guard let font = UIFont(name: FontName.sfProDisplayRegular.rawValue, size: 16.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 16.0, weight: .regular)
        }
        return font
    }
    
    static var gifSFProDisplayRegular20: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplayRegular.rawValue, size: 20.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 20.0, weight: .regular)
        }
        return font
    }
    
    static var gifSFProDisplayMedium8: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplayMedium.rawValue, size: 8.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 8.0, weight: .medium)
        }
        return font
    }
    
    static var gifSFProDisplayMedium14: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplayMedium.rawValue, size: 14.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 14.0, weight: .medium)
        }
        return font
    }
    
    static var gifSFProDisplayMedium15: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplayMedium.rawValue, size: 15.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 15.0, weight: .medium)
        }
        return font
    }
    
    static var gifSFProDisplaySemibold10: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplaySemibold.rawValue, size: 10.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 10.0, weight: .semibold)
        }
        return font
    }
    
    static var gifSFProDisplaySemibold13: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplaySemibold.rawValue, size: 13.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 13.0, weight: .semibold)
        }
        return font
    }
    
    static var gifSFProDisplaySemibold15: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplaySemibold.rawValue, size: 15.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        }
        return font
    }
    
    static var gifSFProDisplaySemibold17: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplaySemibold.rawValue, size: 17.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        }
        return font
    }
    
    static var gifSFProDisplaySemibold20: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplaySemibold.rawValue, size: 20.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        }
        return font
    }
    
    static var gifSFProDisplayBold13: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplayBold.rawValue, size: 13.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 13.0, weight: .bold)
        }
        return font
    }
    
    static var gifSFProDisplayBold15: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplayBold.rawValue, size: 15.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 15.0, weight: .bold)
        }
        return font
    }
    
    static var gifSFProDisplayBold16: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplayBold.rawValue, size: 16.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 16.0, weight: .bold)
        }
        return font
    }
    
    static var gifSFProDisplayBold18: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplayBold.rawValue, size: 18.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 18.0, weight: .bold)
        }
        return font
    }
    
    static var gifSFProDisplayBold20: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplayBold.rawValue, size: 20.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 20.0, weight: .bold)
        }
        return font
    }
    
    static var gifSFProDisplayBold24: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplayBold.rawValue, size: 24.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 24.0, weight: .bold)
        }
        return font
    }
    
    static var gifSFProDisplayBold34: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplayBold.rawValue, size: 34.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 34.0, weight: .bold)
        }
        return font
    }
    
    static var gifSFProDisplayBold40: UIFont {
        guard let font = UIFont(name: FontName.sfProDisplayBold.rawValue, size: 40.0) else {
            ErrorLoggerService.logWithTrace(FontName.errorMessage)
            return UIFont.systemFont(ofSize: 40.0, weight: .bold)
        }
        return font
    }
    
}
