//___FILEHEADER___

import UIKit

protocol Coordinator: AnyObject {
    func start()
}

protocol CoordinatorOutput: AnyObject {
    var finishFlow: (() -> Void)? { get set }
}

protocol CoordinatorViewOutput: AnyObject {
    var flowReadyView: ((_ view: UIView) -> Void)? { get set }
}



