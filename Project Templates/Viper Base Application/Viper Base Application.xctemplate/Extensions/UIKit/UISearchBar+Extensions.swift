//___FILEHEADER___

import UIKit

extension UISearchBar {
    
    private func getViewElement<T>(type: T.Type) -> T? {
        
        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    
    func getSearchBarTextField() -> UITextField? {
        return getViewElement(type: UITextField.self)
    }
    
    func setTextColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            textField.textColor = color
        }
    }
    
    func setTextFieldColor(color: UIColor) {
        
        if let textField = getViewElement(type: UITextField.self) {
            
            textField.layer.backgroundColor = color.cgColor
            textField.layer.cornerRadius = 6
        }
    }
    
    func setPlaceholderTextColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            let placeholder = self.placeholder ?? ""
            let attributes = [NSAttributedString.Key.foregroundColor: color]
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
    }
    
    func setTextFieldClearButtonColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            
            let button = textField.value(forKey: "clearButton") as? UIButton
            if let image = button?.imageView?.image {
                button?.setImage(image.transform(withNewColor: color), for: .normal)
            }
        }
    }
    
    func setSearchImageColor(color: UIColor) {
        
        if let imageView = getSearchBarTextField()?.leftView as? UIImageView {
            imageView.image = imageView.image?.transform(withNewColor: color)
        }
    }
    
    func changeSearchBarTextFieldBacgroundColor(color: UIColor) {
        
        if #available(iOS 13.0, *) {
            self.searchTextField.backgroundColor = color
            
        } else {
            guard let textField = getSearchBarTextField() else {
                return
            }
            textField.backgroundColor = color
            textField.superview?.backgroundColor = .white
        }
    }
    
}
