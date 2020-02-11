//___FILEHEADER___

import Foundation
import UIKit

final class InternalSignUpPresenterImp: BasePresenter, InternalSignUpPresenter {
    
    var viewController: InternalSignUpViewController?
    var interactor: InternalSignUpInteractor?
    
    required init<ViewControllerType, InteractorType>(viewController: ViewControllerType, interactor: InteractorType) where ViewControllerType : ViewController, InteractorType : Interactor {
        
        super.init(viewController: viewController, interactor: interactor)
        
        self.viewController = viewController as? InternalSignUpViewController
        self.interactor = interactor as? InternalSignUpInteractor
    }
    
    func InternalSignUpButtonTouched() {
        guard let userData = viewController?.fetchUserData() else { return }
        interactor?.registerUser(data: userData)
    }
}
