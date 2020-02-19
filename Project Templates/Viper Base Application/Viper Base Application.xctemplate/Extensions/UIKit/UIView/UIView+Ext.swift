//___FILEHEADER___

import UIKit

extension UIView {
    
    static func createLinearGradient(_ colors: [UIColor],
                                     _ frame: CGRect) -> CALayer {
        let newLayer = CAGradientLayer()
        newLayer.frame = frame
        newLayer.colors = colors.map{ $0.cgColor }
        newLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        newLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return newLayer
    }
    
    func createLinearGradient(_ colors: [UIColor]) -> CALayer {
        let newLayer = CAGradientLayer()
        newLayer.frame = self.bounds
        newLayer.colors = colors.map{ $0.cgColor }
        newLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        newLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return newLayer
    }
    
    func createVerticalGradient(_ colors: [UIColor]) -> CALayer {
        let newLayer = CAGradientLayer()
        newLayer.frame = self.bounds
        newLayer.colors = colors.map{ $0.cgColor }
        newLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        newLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        return newLayer
    }
    
    func addLinearGradient(_ colors: [UIColor]) {
        layer.insertSublayer(createLinearGradient(colors), at: 0)
    }
    
    func createRainbowBackground() -> CAGradientLayer {
        let newLayer = CAGradientLayer()
        newLayer.frame = self.bounds
        newLayer.colors = RainbowBackgroundView.colors.map { $0.cgColor }
        newLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        newLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return newLayer
    }
    
    func createRainbowBackground(at rect: CGRect) -> CAGradientLayer {
        let newLayer = CAGradientLayer()
        newLayer.frame = rect
        newLayer.colors = RainbowBackgroundView.colors.map { $0.cgColor }
        newLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        newLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return newLayer
    }
    
    func addRainbowBackground() {
        let newLayer = CAGradientLayer()
        newLayer.frame = self.bounds
        newLayer.colors = RainbowBackgroundView.colors.map { $0.cgColor }
        newLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        newLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(newLayer, at: 0)
    }
    
    func removeLayers() {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    func addRainbowBorder(width: CGFloat, cornerRadius: CGFloat) {
        
        let colors = RainbowBackgroundView.colors
        let gradientBorder = createGradientBorder(width: width, cornerRadius: cornerRadius, colors: colors)
        layer.insertSublayer(gradientBorder, below: layer)
    }
    
    func createGradientBorder(width: CGFloat, cornerRadius: CGFloat, colors: [UIColor]) -> CALayer {
        
        let size = CGSize(width: bounds.size.width, height: bounds.size.height)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        let gradient = CAGradientLayer()
        gradient.frame = rect
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        
        let shape = CAShapeLayer()
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        
        shape.lineWidth = width
        shape.path = path.cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        return gradient
    }
    
}
