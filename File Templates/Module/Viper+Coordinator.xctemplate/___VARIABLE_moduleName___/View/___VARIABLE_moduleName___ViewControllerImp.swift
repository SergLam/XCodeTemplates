//___FILEHEADER___

import Foundation
import UIKit

final class ___VARIABLE_moduleName___ViewControllerImp: BaseViewController<___VARIABLE_moduleName___PresenterImp>, ___VARIABLE_moduleName___ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.configureView()
    }
}
