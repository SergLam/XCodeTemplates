//___FILEHEADER___

import Foundation

final class InternalAuthCoordinatorFactoryImp: InternalAuthCoordinatorFactory {
    static func makeRestoreCoordinator(router: Router) -> (Coordinator & CoordinatorOutput)? {
        return RestoreCoordinatorImp(router: router)
    }
    
    static func makeSignUpCoordinator(router: Router) -> (___VARIABLE_flowName___CoordinatorOutput)? {
        return InternalSignUpCoordinatorImp(router: router)
    }
}
