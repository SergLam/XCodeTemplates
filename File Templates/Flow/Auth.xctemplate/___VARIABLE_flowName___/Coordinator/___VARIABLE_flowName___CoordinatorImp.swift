//___FILEHEADER___

import Foundation
import UIKit

enum ___VARIABLE_flowName___Option {
    case internalAuth, googleAuth, facebookAuth
    static let availableOptions: [___VARIABLE_flowName___Option] = [internalAuth, facebookAuth, googleAuth]
}

final class ___VARIABLE_flowName___CoordinatorImp: BaseCoordinator, ___VARIABLE_flowName___CoordinatorOutput {
    var finishFlow: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)?
    weak var router: Router?

    private let configuratorFactory = ___VARIABLE_flowName___ConfiguratorFactoryImp()
    private var configurator: ___VARIABLE_flowName___Configurator?

    init(router: Router) {
        self.router = router
    }
    
    override func start() {
        configurator = configuratorFactory.make___VARIABLE_flowName___Configurator()
        configureSubflows()
        configurator?.interactor.onAuthComplete = { [weak self] authUser in
            self?.finishFlow?(authUser)
        }
        router?.setRootModule(configurator?.viewController)
    }
    
    func configureSubflows() {
        for option: ___VARIABLE_flowName___Option in ___VARIABLE_flowName___Option.availableOptions {
            startAuthFlow(option: option)
        }
    }
    
    func startAuthFlow(option: ___VARIABLE_flowName___Option) {
        guard let router = router, let coordinator = ___VARIABLE_flowName___CoordinatorFactoryImp.makeCoordinator(option: option, router: router) else { return }
        coordinator.flowReadyView = { [weak self, option] view in
            self?.configurator?.presenter.childFlowViewDict?[option] = view
        }
        coordinator.finishFlow = { [weak self] authUser in
            guard let finishFlow = self?.finishFlow else { return }
            finishFlow(authUser)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
