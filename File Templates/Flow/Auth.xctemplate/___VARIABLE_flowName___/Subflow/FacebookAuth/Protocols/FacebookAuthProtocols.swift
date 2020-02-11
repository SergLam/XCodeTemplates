//___FILEHEADER___

import Foundation
import FacebookLogin

protocol FacebookAuthConfiguratorFactory: class {
    func makeAuthConfigurator() -> FacebookAuthConfigurator
}

protocol FacebookAuthConfigurator: class {
    var viewController: FacebookAuthViewController { get set }
    var delegate: FacebookAuthDelegate { get set }
}

protocol FacebookAuthViewController: BaseView {
    var delegate: FacebookAuthDelegate? { get set }
}

protocol FacebookAuthDelegate: LoginButtonDelegate {
    var facebookAuthComplete: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)? { get set }
}
