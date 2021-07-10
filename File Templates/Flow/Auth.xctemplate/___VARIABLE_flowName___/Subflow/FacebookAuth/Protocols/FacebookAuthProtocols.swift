//___FILEHEADER___

import Foundation
import FacebookLogin

protocol FacebookAuthConfiguratorFactory: AnyObject {
    func makeAuthConfigurator() -> FacebookAuthConfigurator
}

protocol FacebookAuthConfigurator: AnyObject {
    var viewController: FacebookAuthViewController { get set }
    var delegate: FacebookAuthDelegate { get set }
}

protocol FacebookAuthViewController: BaseView {
    var delegate: FacebookAuthDelegate? { get set }
}

protocol FacebookAuthDelegate: LoginButtonDelegate {
    var facebookAuthComplete: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)? { get set }
}
