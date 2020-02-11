//___FILEHEADER___

import Foundation

final class InternalSignUpCoordinatorImp: BaseCoordinator, ___VARIABLE_flowName___CoordinatorOutput {
    var finishFlow: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)?
    weak var router: Router?

    private let configuratorFactory = InternalSignUpConfiguratorFactoryImp()
    private var configurator: InternalSignUpConfigurator?

    init(router: Router) {
        self.router = router
    }
    
    override func start() {
        configurator = configuratorFactory.makeInternalSignUpConfigurator()
        configurator?.interactor.finishInternalSignUpFlow = { [weak self] authUser in
            self?.finishFlow(authUser: authUser)
        }
        configurator?.interactor.onBackButtonPressed = { [weak self] in
            self?.finishFlow(authUser: nil)
        }
        router?.push(configurator?.viewController, animated: true)
    }
    
    func finishFlow(authUser: ___VARIABLE_flowName___User?) {
        router?.popModule()
        guard let finishFlow = finishFlow else { return }
        finishFlow(authUser)
    }
}
