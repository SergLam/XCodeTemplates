//___FILEHEADER___

import Foundation
import UIKit

final class MainCoordinatorImp: BaseCoordinator, CoordinatorOutput, CoordinatorViewOutput {
    
    var flowReadyView: ((UIView) -> Void)?
    var finishFlow: (() -> Void)?
    weak var router: Router?

    private let configuratorFactory = MainConfiguratorFactoryImp()
    private var configurator: MainConfigurator?

    init(router: Router) {
        self.router = router
    }
    
    override func start() {
        configurator = configuratorFactory.makeMainConfigurator()
        configureSubflows()
        configurator?.interactor.onMainComplete = { [weak self] in
            self?.finishFlow?()
        }
        router?.setRootModule(configurator?.viewController)
    }
    
    func configureSubflows() {

    }
}
