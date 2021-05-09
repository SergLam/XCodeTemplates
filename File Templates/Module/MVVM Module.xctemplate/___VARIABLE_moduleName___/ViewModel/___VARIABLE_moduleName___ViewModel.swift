//___FILEHEADER___

import RxSwift
import UIKit

protocol ___VARIABLE_moduleName___ViewModelDelegate: AnyObject {
    
    func didReceiveError(_ error: Error)
}

final class ___VARIABLE_moduleName___ViewModel: NSObject {
    
    weak var delegate: ___VARIABLE_moduleName___ViewModelDelegate?
    
    private lazy var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Life cycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override init() {
        
        super.init()
    }
    
    // MARK: - Public functions
    
    // MARK: - Private functions
    
}
