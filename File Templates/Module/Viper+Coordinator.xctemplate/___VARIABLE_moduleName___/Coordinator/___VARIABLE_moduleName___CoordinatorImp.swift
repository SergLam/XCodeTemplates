//___FILEHEADER___

import Foundation
import UIKit

final class ___VARIABLE_moduleName___CoordinatorImp: BaseCoordinator, ___VARIABLE_moduleName___Coordinator, CoordinatorOutput, CoordinatorViewOutput {
    var flowReadyView: ((UIView) -> Void)?
    var finishFlow: (() -> Void)?
    weak var router: Router?

    private let configuratorFactory = ___VARIABLE_moduleName___ConfiguratorFactoryImp()
    private var configurator: ___VARIABLE_moduleName___Configurator?

    init(router: Router) {
        self.router = router
    }
    
    override func start() {
        configurator = configuratorFactory.make___VARIABLE_moduleName___Configurator()
        configureSubflows()
        configurator?.interactor.on___VARIABLE_moduleName___Complete = { [weak self] in
            self?.finishFlow?()
        }
        router?.setRootModule(configurator?.viewController)
    }
    
    func configureSubflows() {

    }
}
