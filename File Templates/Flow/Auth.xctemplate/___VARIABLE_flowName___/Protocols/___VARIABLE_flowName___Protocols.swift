//___FILEHEADER___
    
import Foundation
import UIKit

extension CoordinatorFactory {
    func make___VARIABLE_flowName___Coordinator(router: Router) -> ___VARIABLE_flowName___CoordinatorOutput {
        let coordinator = ___VARIABLE_flowName___CoordinatorImp(router: router)
        return coordinator
    }
}

protocol ___VARIABLE_flowName___CoordinatorFactory {
    static func makeCoordinator(option: ___VARIABLE_flowName___Option, router: Router) -> (Coordinator & CoordinatorViewOutput & ___VARIABLE_flowName___CoordinatorOutput)?
}

protocol ___VARIABLE_flowName___ConfiguratorFactory: class {
    func make___VARIABLE_flowName___Configurator() -> ___VARIABLE_flowName___Configurator
}

protocol ___VARIABLE_flowName___CoordinatorOutput: Coordinator {
    var finishFlow:((_ authUser: ___VARIABLE_flowName___User?) -> Void)? { get set }
}

protocol ___VARIABLE_flowName___Configurator: BaseConfigurator<___VARIABLE_flowName___ViewControllerImp, ___VARIABLE_flowName___PresenterImp, ___VARIABLE_flowName___InteractorImp> {
}

protocol ___VARIABLE_flowName___ViewController: BaseViewController<___VARIABLE_flowName___PresenterImp> {
    func addContentToStackView(_ child: UIView)
    func addLoginPassView(_ child: UIView)
}

protocol ___VARIABLE_flowName___Presenter: BasePresenter {
    var interactor: ___VARIABLE_flowName___Interactor? { get set }
    var viewController: ___VARIABLE_flowName___ViewController? { get set }
    var childFlowViewDict: [___VARIABLE_flowName___Option : UIView]? { get set }
    
    func configureView()
}

protocol ___VARIABLE_flowName___Interactor: BaseInteractor<___VARIABLE_flowName___PresenterImp> {
    var onAuthComplete: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)? { get set }
}
