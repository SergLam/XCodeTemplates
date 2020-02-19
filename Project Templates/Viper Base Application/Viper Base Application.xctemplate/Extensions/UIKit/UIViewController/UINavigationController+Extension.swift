//___FILEHEADER___

import UIKit

extension UINavigationController {
    
    open override var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
    
    func transparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
      if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
        popToViewController(vc, animated: animated)
      }
    }
    
    func containsController(ofClass: AnyClass) -> Bool {
        return viewControllers.first(where: { $0.isKind(of: ofClass) }) != nil
    }
    
    func getViewController(ofClass: AnyClass) -> UIViewController? {
        return viewControllers.first(where: { $0.isKind(of: ofClass) })
    }
    
}
