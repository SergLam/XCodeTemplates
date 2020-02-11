//___FILEHEADER___

import Foundation
import UIKit

final class RestorePresenterImp: BasePresenter, RestorePresenter {
    
    weak var interactor: RestoreInteractor?
    weak var viewController: RestoreViewController?
    
    required init<ViewControllerType, InteractorType>(viewController: ViewControllerType, interactor: InteractorType) where ViewControllerType : ViewController, InteractorType : Interactor {
        super.init(viewController: viewController, interactor: interactor)
        self.viewController = viewController as? RestoreViewController
        self.interactor = interactor as? RestoreInteractor
    }
    
    func sendButtonTouched() {
        guard let userData = viewController?.fetchUserData() else { return }
        interactor?.restoreUser(data: userData)
    }
}
