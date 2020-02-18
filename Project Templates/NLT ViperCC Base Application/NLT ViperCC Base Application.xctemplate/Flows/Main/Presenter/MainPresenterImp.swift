//___FILEHEADER___

import Foundation
import UIKit

final class MainPresenterImp: BasePresenter, MainPresenter {
    
    weak var interactor: MainInteractor?
    weak var viewController: MainViewController?
    
    required init<ViewControllerType, InteractorType>(viewController: ViewControllerType, interactor: InteractorType) where ViewControllerType : ViewController, InteractorType : Interactor {
        super.init(viewController: viewController, interactor: interactor)
        self.viewController = viewController as? MainViewController
        self.interactor = interactor as? MainInteractor
    }
    
    func signOutButtonPressed() {
        interactor?.signOutButtonPressed()
    }
}
