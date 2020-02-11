//___FILEHEADER___

import Foundation
import UIKit

final class InternalAuthCoordinatorImp: BaseCoordinator, InternalAuthCoordinator, CoordinatorViewOutput, ___VARIABLE_flowName___CoordinatorOutput {
    var flowReadyView: ((UIView) -> Void)?
    var finishFlow: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)?

    private let configuratorFactory = InternalAuthConfiguratorFactoryImp()
    
    private var internalAuthConfigurator: InternalAuthConfigurator?

    weak var router: Router?

    init(router: Router) {
        self.router = router
    }

    override func start() {
        internalAuthConfigurator = configuratorFactory.makeInternalAuthConfigurator()
        internalAuthConfigurator?.interactor.onInternalAuthComplete = { [weak self] authUser in
            self?.finishFlow?(authUser)
        }
        internalAuthConfigurator?.interactor.onStartSignUpFlow = { [weak self] in
            self?.runSignUpFlow()
        }
        internalAuthConfigurator?.interactor.onStartRestoreFlow = { [weak self] in
            self?.runRestoreFlow()
        }
        guard let flowView = internalAuthConfigurator?.viewController.toPresent()?.view else  { return }
        self.flowReadyView?(flowView)
    }
    
    func runSignUpFlow() {
        guard let router = router, let coordinator = InternalAuthCoordinatorFactoryImp.makeSignUpCoordinator(router: router) else { return }
        coordinator.finishFlow = { [weak self, weak coordinator] authUser in
            self?.removeDependency(coordinator)
            guard let finishFlow = self?.finishFlow else { return }
            finishFlow(authUser)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func runRestoreFlow() {
        guard let router = router, let coordinator = InternalAuthCoordinatorFactoryImp.makeRestoreCoordinator(router: router) else { return }
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
