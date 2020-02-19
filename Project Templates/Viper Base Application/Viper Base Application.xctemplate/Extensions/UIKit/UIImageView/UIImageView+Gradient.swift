//___FILEHEADER___

import UIKit

extension UIImageView {

    func addAvatarGradientBorder(_ width: CGFloat) {
        let colors: [UIColor] = [.supSoftGreenThree, .supSoftGreenTwo,
                                 .supSoftGreen, .supTea,
                                 .supAquaMarineTwo, .supAquaMarineThree,
                                 .supAquaMarineFour, .supAquaMarineFive,
                                 .supAzureThree, .supAzureFour, .supAzure]
        addCircleGradiendBorder(width, colors)
    }
    
    func addCircleGradiendBorder(_ width: CGFloat, _ colors: [UIColor]) {
        
        layer.insertSublayer(createCircleGradientBorder(width, colors), below: layer)
    }
    
    func createCircleGradientBorder(_ width: CGFloat, _ colors: [UIColor]) -> CALayer {
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
        let cgColors: [CGColor] = colors.map { $0.cgColor }
        gradient.colors = cgColors
        gradient.startPoint = CGPoint(x: 1, y: 0.5)
        gradient.endPoint = CGPoint(x: 0, y: 0.5)
        
        let cornerRadius = frame.size.width / 2
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        
        let shape = CAShapeLayer()
        let path = UIBezierPath(ovalIn: bounds)
        
        shape.lineWidth = width
        shape.path = path.cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        return gradient
    }
    
    func removeGradientLayer() {
        layer.sublayers?.forEach{ $0.removeFromSuperlayer() }
    }
    
    func addSomeoneTypingCircleGradient() {
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
        let colors: [UIColor] = [.supBlueWithAHintOfPurple, .supDeepLavenderTwo,
                                 .supPurplishPink, .supBarbiePink, .supCoralPink]
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        let cornerRadius = frame.size.width / 2
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        
        layer.insertSublayer(gradient, below: layer)
    }
    
}
