//___FILEHEADER___

import Foundation

final class ___VARIABLE_flowName___CoordinatorFactoryImp: ___VARIABLE_flowName___CoordinatorFactory {
    static func makeCoordinator(option: ___VARIABLE_flowName___Option, router: Router) -> (Coordinator & CoordinatorViewOutput & ___VARIABLE_flowName___CoordinatorOutput)? {
        switch option {
            case .internalAuth: return InternalAuthCoordinatorImp(router: router)
            case .googleAuth: return GoogleAuthCoordinatorImp()
            case .facebookAuth: return FacebookAuthCoordinatorImp()
        }
    }

}
