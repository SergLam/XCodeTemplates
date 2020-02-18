//___FILEHEADER___

import Foundation
import UIKit

class BasePresenter: NSObject, Presenter {

    private weak var _interactor: BaseInteractorProtocol?
    private weak var _viewController: BaseViewControllerProtocol?
        
    required init<ViewControllerType, InteractorType>(viewController: ViewControllerType, interactor: InteractorType) where ViewControllerType : ViewController, InteractorType : Interactor {
        _viewController = viewController
        _interactor = interactor
    }
    
    func pressedBackButton() {
        _interactor?.pressedBackButton()
    }
    
    func showError(title:String, error: Error) {
        _viewController?.showError(title: title, error: error)
    }
    
}
