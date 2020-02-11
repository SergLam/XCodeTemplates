//___FILEHEADER___

import Foundation
import UIKit

final class RestoreCoordinatorImp: BaseCoordinator, CoordinatorOutput {
    var finishFlow: (() -> Void)?
    weak var router: Router?

    private let configuratorFactory = RestoreConfiguratorFactoryImp()
    private var configurator: RestoreConfigurator?

    init(router: Router) {
        self.router = router
    }
    
    override func start() {
        configurator = configuratorFactory.makeRestoreConfigurator()
        configureSubflows()
        configurator?.interactor.onRestoreComplete = { [weak self] in
            self?.router?.popModule()
            self?.finishFlow?()
        }
        configurator?.interactor.onBackButtonPressed = { [weak self] in
            self?.finishFlow?()
        }
        router?.push(configurator?.viewController, animated: true)
    }
    
    func configureSubflows() {

    }
}
