//___FILEHEADER___

import Foundation

protocol BasePresenterProtocol: NSObject {
    func pressedBackButton()
    func showError(title:String, error: Error)
}

protocol Presenter: BasePresenterProtocol {
    init <ViewControllerType: ViewController, InteractorType: Interactor>(viewController:ViewControllerType, interactor:InteractorType)
}
