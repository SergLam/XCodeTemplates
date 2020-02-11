//___FILEHEADER___

import Foundation
import UIKit

protocol RestoreViewDataSourceProtocol: BaseViewDataSource {
    var email: String { get set }
}

struct RestoreViewUserData: RestoreViewDataSourceProtocol {
    var email: String
}

@IBDesignable

final class RestoreView: UIView, DataReturnable {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet var contentView: UIView!
    
    var viewData: RestoreViewUserData? {
        get { if (checkFields() == false) { return nil }
            return RestoreViewUserData(email: emailField.text!)
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
           let bundle = Bundle(for: RestoreView.self)
           bundle.loadNibNamed(String(describing: RestoreView.self), owner: self, options: nil)
           addSubview(contentView)
           contentView.frame = self.bounds
           contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       }
    
    private func checkFields() -> Bool {
        guard
            let email = emailField.text,
            email.count > 0
            else { return false }
        return true
    }
}
