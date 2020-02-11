//___FILEHEADER___

import Foundation
import UIKit
import FacebookLogin

final class FacebookAuthViewControllerImp: UIViewController, FacebookAuthViewController {
    weak var delegate: FacebookAuthDelegate?
    @IBOutlet weak var loginButton: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame.size = CGSize(width: 350.0, height: 40.0)

        configureLoginButton()
    }
    
    func configureLoginButton() {
        loginButton.delegate = delegate
        loginButton.permissions = ["email"]
    }
}
