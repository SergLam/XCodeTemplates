//___FILEHEADER___

import UIKit

protocol Coordinator: class {
    func start()
}

protocol CoordinatorOutput: class {
    var finishFlow: (() -> Void)? { get set }
}

protocol CoordinatorViewOutput: class {
    var flowReadyView: ((_ view: UIView) -> Void)? { get set }
}



