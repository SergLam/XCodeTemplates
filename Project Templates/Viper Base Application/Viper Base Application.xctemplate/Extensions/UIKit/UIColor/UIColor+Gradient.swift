//___FILEHEADER___

import UIKit

extension UIColor {
    
    static func linearGradientColor(from colors: [UIColor], locations: [CGFloat], size: CGSize) -> UIColor? {
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let image = UIGraphicsImageRenderer(bounds: rect).image { context in
            let cgColors = colors.map { $0.cgColor } as CFArray
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors, locations: locations) else {
                let message: String = "Unable to create gradient color"
                ErrorLoggerService.logWithTrace(message)
                return
            }
            let startPoint: CGPoint = CGPoint(x: 0, y: 0)
            let endPoint: CGPoint = CGPoint(x: size.width, y: 0)
            context.cgContext.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        }
        return UIColor(patternImage: image)
    }
    
}
