//___FILEHEADER___

import Foundation

class BaseConfigurator<ViewControllerType: ViewController, PresenterType: Presenter, InteractorType: Interactor>: Configurator {
    
    var viewController: ViewControllerType
    var presenter: PresenterType
    var interactor: InteractorType
    
    init() {
        viewController = ViewControllerType.controllerFromStoryboard(String(describing: ViewControllerType.self))
        interactor = InteractorType()
        presenter = PresenterType(viewController: viewController, interactor: interactor)
        interactor.presenter = presenter as? InteractorType.PresenterType
        viewController.presenter = presenter as? ViewControllerType.PresenterType
    }
}
