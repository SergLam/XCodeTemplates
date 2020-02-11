//___FILEHEADER___

import Foundation
import GoogleSignIn

final class GoogleAuthConfiguratorImp: GoogleAuthConfigurator {
    var delegate: GoogleAuthDelegate
    var viewController: GoogleAuthViewController
    
    init() {
        viewController = GoogleAuthViewControllerImp.controllerFromStoryboard(String(describing: GoogleAuthViewController.self))
        delegate = GoogleAuthDelegateImp()
        GIDSignIn.sharedInstance().delegate = delegate
        viewController.delegate = delegate
    }
}
