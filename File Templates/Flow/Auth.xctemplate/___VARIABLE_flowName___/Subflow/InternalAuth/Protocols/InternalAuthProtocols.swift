//___FILEHEADER___
    
import Foundation
import UIKit

protocol InternalAuthCoordinatorFactory {
    static func makeSignUpCoordinator(router: Router) -> (Coordinator & ___VARIABLE_flowName___CoordinatorOutput)?
    static func makeRestoreCoordinator(router: Router) -> (Coordinator & CoordinatorOutput)?
}

protocol InternalAuthConfiguratorFactory: class {
    func makeInternalAuthConfigurator() -> InternalAuthConfigurator
}

protocol InternalAuthCoordinator: Coordinator {
    var finishFlow: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)? { get set }
}

protocol InternalAuthConfigurator: BaseConfigurator<InternalAuthViewControllerImp, InternalAuthPresenterImp, InternalAuthInteractorImp> {
}

protocol InternalAuthViewController: BaseViewController<InternalAuthPresenterImp> {
    func fetchUserData() -> AuthLogPassUserData?
}

protocol InternalAuthPresenter: BasePresenter {
    var interactor: InternalAuthInteractor? { get set }
    var viewController: InternalAuthViewController? { get set }
    
    func signInButtonTouched()
    func signUpButtonTouched()
    func forgotAccountButtonTouched()
}

protocol InternalAuthInteractor: BaseInteractor<InternalAuthPresenterImp> {
    var onInternalAuthComplete: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)? { get set }
    var onStartSignUpFlow: (() -> Void)? { get set }
    var onStartRestoreFlow: (() -> Void)? { get set }
    
    func signIn(with userData: AuthLogPassUserData)
    func signUp()
    func restore()
}
