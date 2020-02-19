//___FILEHEADER___

import UIKit

extension UIScrollView {
    
    func changeScrollIndicatorColor(to color: UIColor) {
        
        if #available(iOS 13, *) {
            let verticalIndicator = (self.subviews[(self.subviews.count - 1)].subviews[0])
            verticalIndicator.backgroundColor = color
            
            let horizontalIndicator = (self.subviews[(self.subviews.count - 2)].subviews[0])
            horizontalIndicator.backgroundColor = color
            
        } else {
            if let verticalIndicator: UIImageView = (self.subviews[(self.subviews.count - 1)] as? UIImageView) {
                let width = verticalIndicator.bounds.width
                let height = verticalIndicator.bounds.height
                verticalIndicator.image = color.imageWithColor(width: width, height: height)
                
            }
            if let horizontalIndicator: UIImageView = (self.subviews[(self.subviews.count - 2)] as? UIImageView) {
                let width = horizontalIndicator.bounds.width
                let height = horizontalIndicator.bounds.height
                horizontalIndicator.image = color.imageWithColor(width: width, height: height)
            }
        }
    }
    
    func getScrollDirection(for type: ScrollType, _ oldOffset: CGFloat, _ newOffset: CGFloat) -> ScrollDirection {
        
        switch type {
        case .vertical:
            guard oldOffset > newOffset else {
                return ScrollDirection.down
            }
            return ScrollDirection.up
            
        case .horizontal:
            guard oldOffset > newOffset else {
                return ScrollDirection.right
            }
            return ScrollDirection.left
        }
    }
    
}
