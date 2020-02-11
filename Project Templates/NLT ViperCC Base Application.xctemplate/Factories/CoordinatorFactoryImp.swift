//___FILEHEADER___

import Foundation

final class CoordinatorFactoryImp: CoordinatorFactory {
    func makeMainCoordinator(router: Router) -> Coordinator & CoordinatorOutput {
        let coordinator = MainCoordinatorImp(router: router)
        return coordinator
    }
}
