//___FILEHEADER___

import Foundation
import UIKit
import GoogleSignIn

final class GoogleAuthViewControllerImp: UIViewController, GoogleAuthViewController {
    @IBOutlet weak var loginButton: GIDSignInButton!
    weak var delegate: GoogleAuthDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame.size = CGSize(width: 350.0, height: 40.0)
        
        configureLoginButton()
    }
    
    func configureLoginButton() {
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = delegate
    }
}
