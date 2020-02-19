//___FILEHEADER___

import UIKit

enum ScreenType: CGFloat, CaseIterable {
    case unknown = 0
    
    case iphoneSE = 1136
    case iphone678 = 1334
    case iphone678plus = 1920
    
    case iphoneXR = 1792
    case iphoneXXs = 2436
    case iphoneXMax = 2688
}

extension UIScreen {
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var pixelsHeight: CGFloat {
        return UIScreen.main.nativeBounds.height
    }
    static var pixelsWidth: CGFloat {
        return UIScreen.main.nativeBounds.width
    }
    
    static var pixelsScale: CGFloat {
        return UIScreen.main.nativeScale
    }
    
    static var model: ScreenType {
        return ScreenType(rawValue: self.height * UIScreen.main.scale) ?? ScreenType.unknown
    }
    
}
