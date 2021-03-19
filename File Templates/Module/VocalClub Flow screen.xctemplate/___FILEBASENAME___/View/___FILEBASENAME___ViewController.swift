//___FILEHEADER___

import UIKit

final class ___VARIABLE_screenModuleName___ViewController: UIViewController, ___VARIABLE_screenModuleName___ViewControllerProtocol {
    
    typealias Presenter = ___VARIABLE_screenModuleName___Presenter<___VARIABLE_screenModuleName___ViewController, ___VARIABLE_screenModuleName___Factory>
    
    var presenter: Presenter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewChangedState(state: .didLoad)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewChangedState(state: .willAppear)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewChangedState(state: .didAppear)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewChangedState(state: .willDisappear)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewChangedState(state: .didDisappear)
    }

}
