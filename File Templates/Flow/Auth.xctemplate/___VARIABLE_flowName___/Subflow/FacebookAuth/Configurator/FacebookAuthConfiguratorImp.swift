//___FILEHEADER___

import Foundation
import FacebookLogin

final class FacebookAuthConfiguratorImp: FacebookAuthConfigurator {
    var delegate: FacebookAuthDelegate
    var viewController: FacebookAuthViewController
    
    init() {
        viewController = FacebookAuthViewControllerImp.controllerFromStoryboard(String(describing: FacebookAuthViewController.self))
        delegate = FacebookAuthDelegateImp()
        viewController.delegate = delegate
    }
}
