//___FILEHEADER___

import UIKit

final class ___VARIABLE_coordinatorName___Coordinator: CoordinatorProtocol {
    
    var type: CoordinatorTypes = .___VARIABLE_coordinatorType___
    
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: VCNavigationController
    var errorHandlingService: ErrorsHandlingServiceProtocol
    var storage: StorageMementoProtocol
    var apiClient: APIClientProtocol
    var socketClient: WebSocketClientProtocol
    
    weak var parrentCoordinator: CoordinatorProtocol?
    
    required init(navigationController: VCNavigationController,
                  errorHandlingService: ErrorsHandlingServiceProtocol,
                  storage: StorageMementoProtocol,
                  apiClient: APIClientProtocol,
                  socketClient: WebSocketClientProtocol) {
        
        self.navigationController = navigationController
        self.errorHandlingService = errorHandlingService
        self.storage = storage
        self.apiClient = apiClient
        self.socketClient = socketClient
    }

    func start() {
        
        // let vc = <YOUR_MODULE_BUILDER>.build()
        // navigationController.pushViewController(vc, animated: true)
    }
    
    func didFinish(_ child: CoordinatorProtocol?, model: ModelProtocol?) {
        
        parrentCoordinator?.didFinish(self, model: model)
    }
    
}
