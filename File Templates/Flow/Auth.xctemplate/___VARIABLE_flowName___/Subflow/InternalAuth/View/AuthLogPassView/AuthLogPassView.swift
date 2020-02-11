//___FILEHEADER___

import Foundation
import UIKit

protocol AuthLogPassViewDataSourceProtocol: BaseViewDataSource {
    var email: String { get set }
    var password: String { get set }
}

struct AuthLogPassUserData: AuthLogPassViewDataSourceProtocol {
    var email: String
    var password: String
}

@IBDesignable

final class AuthLogPassView: UIView, DataReturnable {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
       
    @IBOutlet var contentView: UIView!
    
    var viewData: AuthLogPassUserData? {
        get { if (checkFields() == false) { return nil }
            return AuthLogPassUserData(email: emailField.text!, password: passwordField.text!)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: AuthLogPassView.self)
        bundle.loadNibNamed(String(describing: AuthLogPassView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func checkFields() -> Bool {
        guard
            let email = emailField.text,
            let password = passwordField.text,
            email.count > 0,
            password.count > 0
            else { return false }
        
        return true
    }
}
