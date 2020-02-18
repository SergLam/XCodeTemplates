//___FILEHEADER___

import Foundation

fileprivate var isAutorized = true

fileprivate enum LaunchInstructor {
    case main, auth
    
    static func configure(
        isAutorized: Bool = isAutorized) -> LaunchInstructor {
        
        switch (isAutorized) {
        case (false): return .auth
        case (true): return .main
        }
    }
}


final class ApplicationCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    private var instructor: LaunchInstructor {
        return LaunchInstructor.configure()
    }

    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        switch instructor {
        case .auth: runAuthFlow()
        case .main: runMainFlow()
        }
    }
    
    private func runAuthFlow() {
//        let coordinator = coordinatorFactory.makeAuthCoordinator(router: router)
//        coordinator.finishFlow = { [weak self, weak coordinator] authUser in
//            guard authUser != nil else { return }
//            isAutorized = true
//            self?.start()
//            self?.removeDependency(coordinator)
//        }
//        addDependency(coordinator)
//        coordinator.start()
    }
    
    
    private func runMainFlow() {
        let coordinator = coordinatorFactory.makeMainCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            isAutorized = false
            self?.start()
            self?.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
