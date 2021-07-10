//___FILEHEADER___

import Foundation

protocol Configurator: AnyObject {
    associatedtype ViewControllerType = ViewController
    associatedtype PresenterType = Presenter
    associatedtype InteractorType = Interactor
    
    var viewController: ViewControllerType { get set }
    var presenter: PresenterType { get set }
    var interactor: InteractorType { get set }
}
