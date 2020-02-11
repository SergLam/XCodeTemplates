//___FILEHEADER___

import Foundation
import UIKit

final class InternalAuthViewControllerImp: BaseViewController<InternalAuthPresenterImp>, InternalAuthViewController {
        
    @IBOutlet weak var loginPassView: AuthLogPassView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame.size = CGSize(width: 278.0, height: 295.0)

    }
    
    func fetchUserData() -> AuthLogPassUserData? {
        return loginPassView.viewData
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        presenter?.signInButtonTouched()
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        presenter?.signUpButtonTouched()
    }
    @IBAction func forgotAcoountButtonPressed(_ sender: Any) {
        presenter?.forgotAccountButtonTouched()
    }
}

