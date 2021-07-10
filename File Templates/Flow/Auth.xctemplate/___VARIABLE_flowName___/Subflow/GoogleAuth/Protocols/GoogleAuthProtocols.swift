//___FILEHEADER___

import Foundation
import GoogleSignIn

protocol GoogleAuthConfiguratorFactory: AnyObject {
    func makeAuthConfigurator() -> GoogleAuthConfigurator
}

protocol GoogleAuthConfigurator: AnyObject {
    var viewController: GoogleAuthViewController { get set }
    var delegate: GoogleAuthDelegate { get set }
}

protocol GoogleAuthViewController: BaseView {
    var delegate: GoogleAuthDelegate? { get set }
}

protocol GoogleAuthDelegate: GIDSignInDelegate {
    var googleAuthComplete: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)? { get set }
}
