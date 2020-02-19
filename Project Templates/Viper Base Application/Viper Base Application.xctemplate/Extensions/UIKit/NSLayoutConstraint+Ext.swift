//___FILEHEADER___

import UIKit

extension NSLayoutConstraint {
    
    /**
     Returns same constraint with updated multiplier.
     Do not use for UITableViewCell / CollectionCell
    */
    func changeMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        guard let item = firstItem else {
            let message: String = "Unable to change constraint multiplier"
            ErrorLoggerService.logWithTrace(message)
            return self
        }
        let newConstraint = NSLayoutConstraint(
            item: item,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        newConstraint.priority = priority
        
        NSLayoutConstraint.deactivate([self])
        NSLayoutConstraint.activate([newConstraint])
        
        return newConstraint
    }
}
