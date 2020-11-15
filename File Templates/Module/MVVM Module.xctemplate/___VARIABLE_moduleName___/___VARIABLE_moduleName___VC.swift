//___FILEHEADER___

import SnapKit
import UIKit

final class ___VARIABLE_moduleName___VC: BaseViewController {
    
    private lazy var contentView: ___VARIABLE_moduleName___VCView = ___VARIABLE_moduleName___VCView()
    
    private lazy var viewModel: ___VARIABLE_moduleName___ViewModel = ___VARIABLE_moduleName___ViewModel()
    
    // MARK: - Life cycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init controller programmaticaly, please")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Private functions
    private func setup() {
        
        viewModel.delegate = self
        contentView.delegate = self
    }
    
}

// MARK: - ___VARIABLE_moduleName___VCViewDelegate
extension ___VARIABLE_moduleName___VC: ___VARIABLE_moduleName___VCViewDelegate {
    
}

// MARK: - ___VARIABLE_moduleName___ViewModelDelegate
extension ___VARIABLE_moduleName___VC: ___VARIABLE_moduleName___ViewModelDelegate {
    
    func didReceiveError(_ error: Error) {
        
        hideProgress()
        AlertPresenter.showErrorAlertWithHandler(at: self, errorMessgage: error.localizedDescription, handler: { _ in
            switch error {
            case AuthError.notAuthorized:
                AuthError.handleError(error: AuthError.notAuthorized)
            default:
                break
            }
        })
    }
    
}
