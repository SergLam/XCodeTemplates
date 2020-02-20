//___FILEHEADER___

import JGProgressHUD
import UIKit

protocol ProgressShowable {
    
    func showProgress()
    func hideProgress()
    func hideProgress(completion: @escaping VoidClosure)
}

extension ProgressShowable where Self: BaseViewController {
    
    func showProgress() {
        
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.hud.textLabel.text = Localizable.loading()
            self.hud.show(in: self.view)
        }
    }
    
    func showProgress(_ text: String? = nil) {
        
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.hud.textLabel.text = text ?? Localizable.loading()
            self.hud.show(in: self.view)
        }
    }
    
    func hideProgress() {
        
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.hud.dismiss()
        }
    }
    
    func hideProgress(completion: @escaping VoidClosure) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.hud.dismiss(animated: false)
            completion()
        }
    }
}
