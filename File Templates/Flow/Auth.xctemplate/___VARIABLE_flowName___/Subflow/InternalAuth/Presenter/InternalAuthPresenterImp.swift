//___FILEHEADER___

import Foundation
import UIKit

final class InternalAuthPresenterImp: BasePresenter, InternalAuthPresenter {

    weak var interactor: InternalAuthInteractor?
    weak var viewController: InternalAuthViewController?
    
    required init<ViewControllerType, InteractorType>(viewController: ViewControllerType, interactor: InteractorType) where ViewControllerType : ViewController, InteractorType : Interactor {
        super.init(viewController: viewController, interactor: interactor)
        self.viewController = viewController as? InternalAuthViewController
        self.interactor = interactor as? InternalAuthInteractor
    }
    
    func signInButtonTouched() {
        guard let user = viewController?.fetchUserData() else { return }
        interactor?.signIn(with: user)
    }
    
    func signUpButtonTouched() {
        interactor?.signUp()
    }
    
    func forgotAccountButtonTouched() {
        interactor?.restore()
    }
}
