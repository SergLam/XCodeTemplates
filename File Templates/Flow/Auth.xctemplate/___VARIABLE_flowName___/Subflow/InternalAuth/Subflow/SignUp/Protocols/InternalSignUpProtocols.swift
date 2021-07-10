//___FILEHEADER___
    
import Foundation
import UIKit

protocol InternalSignUpConfiguratorFactory: AnyObject {
    func makeInternalSignUpConfigurator() -> InternalSignUpConfigurator
}

protocol InternalSignUpConfigurator: BaseConfigurator<InternalSignUpViewControllerImp, InternalSignUpPresenterImp, InternalSignUpInteractorImp> {
}

protocol InternalSignUpViewController: BaseViewController<InternalSignUpPresenterImp> {
    func fetchUserData() -> AuthLogPassUserData?
}

protocol InternalSignUpPresenter: BasePresenter {
    var viewController: InternalSignUpViewController? { get set }
    var interactor: InternalSignUpInteractor? { get set }

    func InternalSignUpButtonTouched()
}

protocol InternalSignUpInteractor: BaseInteractor<InternalSignUpPresenterImp> {
    var finishInternalSignUpFlow: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)? { get set }
    func registerUser(data: AuthLogPassUserData)
}
