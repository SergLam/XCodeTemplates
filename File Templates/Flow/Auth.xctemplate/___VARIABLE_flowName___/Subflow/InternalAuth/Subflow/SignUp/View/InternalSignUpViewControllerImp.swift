//___FILEHEADER___

import Foundation
import UIKit

final class InternalSignUpViewControllerImp: BaseViewController<InternalSignUpPresenterImp>, InternalSignUpViewController {

    @IBOutlet weak var InternalSignUpView: AuthLogPassView!
    @IBAction func InternalSignUpButtonAction(_ sender: Any) {
        presenter?.InternalSignUpButtonTouched()
    }
    
    func fetchUserData() -> AuthLogPassUserData? {
        guard let data = InternalSignUpView.viewData else { return nil }
        return data
    }
}
