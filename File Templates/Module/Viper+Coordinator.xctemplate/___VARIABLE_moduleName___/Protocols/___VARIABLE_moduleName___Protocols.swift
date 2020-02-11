//___FILEHEADER___
    
import Foundation
import UIKit

protocol ___VARIABLE_moduleName___ConfiguratorFactory: class {
    func make___VARIABLE_moduleName___Configurator() -> ___VARIABLE_moduleName___Configurator
}

protocol ___VARIABLE_moduleName___Coordinator: Coordinator {

}

protocol ___VARIABLE_moduleName___Configurator: BaseConfigurator<___VARIABLE_moduleName___ViewControllerImp, ___VARIABLE_moduleName___PresenterImp, ___VARIABLE_moduleName___InteractorImp> {
}

protocol ___VARIABLE_moduleName___ViewController: BaseViewController<___VARIABLE_moduleName___PresenterImp> {
}

protocol ___VARIABLE_moduleName___Presenter: BasePresenter {
    var interactor: ___VARIABLE_moduleName___Interactor? { set get }
    var viewController: ___VARIABLE_moduleName___ViewController? { set get }
    var childFlowViewArray: [UIView]? { set get }
    
    func configureView()
}

protocol ___VARIABLE_moduleName___Interactor: BaseInteractor<___VARIABLE_moduleName___PresenterImp> {
    var on___VARIABLE_moduleName___Complete: (() -> Void)? { get set }
}
