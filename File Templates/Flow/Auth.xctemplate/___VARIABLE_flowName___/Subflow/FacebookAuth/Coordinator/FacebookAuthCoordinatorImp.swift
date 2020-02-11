//___FILEHEADER___

import Foundation
import UIKit

final class FacebookAuthCoordinatorImp: BaseCoordinator, ___VARIABLE_flowName___CoordinatorOutput, CoordinatorViewOutput {
    var finishFlow:((_ authUser: ___VARIABLE_flowName___User?) -> Void)?
    var flowReadyView: ((_ view: UIView) -> Void)?

    
    private let configuratorFactory = FacebookAuthConfiguratorFactoryImp()

    private var facebookAuthConfigurator: FacebookAuthConfigurator?
    
    override func start() {
        facebookAuthConfigurator = configuratorFactory.makeAuthConfigurator()
        facebookAuthConfigurator?.delegate.facebookAuthComplete = { [weak self] authUser in
            self?.finishFlow?(authUser)
        }
        guard let flowView = facebookAuthConfigurator?.viewController.toPresent()?.view else  { return }
        self.flowReadyView?(flowView)
    }
}
