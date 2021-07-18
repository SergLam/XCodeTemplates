//___FILEHEADER___

import Foundation
import UIKit

final class ___VARIABLE_moduleName___VC: BaseViewController, ___VARIABLE_moduleName___ViewProtocol {
    
    weak var presenter: ___VARIABLE_moduleName___PresenterProtocol?
    weak var dataSource: ___VARIABLE_moduleName___DataSourceProtocol?
    
    private let contentView: ___VARIABLE_moduleName___VCView = ___VARIABLE_moduleName___VCView()
    
    // MARK: - Life cycle
    deinit {
        
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - ___VARIABLE_moduleName___ViewProtocol
extension ___VARIABLE_moduleName___VC {
    
    func didReceiveError(error: Error) {
        AlertPresenter.showErrorAlert(at: self, errorMessage: error.localizedDescription)
    }
    
    func prepareToDeinit() {
        
    }
    
}
