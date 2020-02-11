//___FILEHEADER___

import Foundation
import UIKit

final class GoogleAuthCoordinatorImp: BaseCoordinator, ___VARIABLE_flowName___CoordinatorOutput, CoordinatorViewOutput {
    var finishFlow:((_ authUser: ___VARIABLE_flowName___User?) -> Void)?
    var flowReadyView: ((_ view: UIView) -> Void)?

    
    private let configuratorFactory = GoogleAuthConfiguratorFactoryImp()

    private var GoogleAuthConfigurator: GoogleAuthConfigurator?
    
    override func start() {
        GoogleAuthConfigurator = configuratorFactory.makeAuthConfigurator()
        GoogleAuthConfigurator?.delegate.googleAuthComplete = { [weak self] authUser in
            self?.finishFlow?(authUser)
        }
        guard let flowView = GoogleAuthConfigurator?.viewController.toPresent()?.view else  { return }
        self.flowReadyView?(flowView)
    }
}
