//___FILEHEADER___

import Foundation
import UIKit

final class ___VARIABLE_moduleName___VC: BaseViewController, ___VARIABLE_moduleName___ViewProtocol {
    
    private let contentView: ___VARIABLE_moduleName___VCView = ___VARIABLE_moduleName___VCView()
    
    // MARK: - Life cycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - ___VARIABLE_moduleName___ViewProtocol
extension ___VARIABLE_moduleName___VC {
    
    func didReceivedError(error: String) {
        AlertPresenter.showErrorAlert(at: self, errorMessgage: error)
    }
    
}
