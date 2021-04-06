//___FILEHEADER___

import UIKit

final class ___VARIABLE_coordinatorName___Coordinator: BaseCoordinator {
    
    override var type: CoordinatorType {
        return .___VARIABLE_coordinatorType___
    }
    
    // MARK: - Life cycle
    init(navVC: UINavigationController) {
        let router = BaseRouter(rootNavigationController: navVC)
        super.init(router: router)
    }
    
    override func onStart() {
        super.onStart()
        start()
    }
    
    override func childDidFinish(_ child: Coordinator) {
        super.childDidFinish(child)
    }
    
    func start() {
        
        // let vc = <YOUR_MODULE_BUILDER>.build()
        // navigationController.pushViewController(vc, animated: true)
    }
    
}
