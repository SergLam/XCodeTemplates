//___FILEHEADER___

import UIKit

extension UIResponder {
    
    func executeOnMain(closure: @escaping VoidClosure) {
        if Thread.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async {
                closure()
            }
        }
    }
    
}
