//___FILEHEADER___

import Foundation
import UIKit

class BaseViewController<PresenterType: Presenter>: UIViewController, ViewController {
    weak var presenter: PresenterType?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isMovingFromParent {
            presenter?.pressedBackButton()
        }
    }
}
