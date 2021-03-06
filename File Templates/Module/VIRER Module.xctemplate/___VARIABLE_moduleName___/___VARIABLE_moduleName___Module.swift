//___FILEHEADER___
    
import Foundation
import UIKit

final class ___VARIABLE_moduleName___Module: ___VARIABLE_moduleName___ModuleProtocol {

    var interactor: ___VARIABLE_moduleName___InteractorProtocol
    var presenter: ___VARIABLE_moduleName___PresenterProtocol
    var view: ___VARIABLE_moduleName___ViewProtocol
    var dataSource: ___VARIABLE_moduleName___DataSourceProtocol
    
    var onBackSelected: VoidClosure?
    
    // MARK: - Life cycle
    deinit {
        
    }
    
    init(interactor: ___VARIABLE_moduleName___InteractorProtocol,
         presenter: ___VARIABLE_moduleName___PresenterProtocol,
         view: ___VARIABLE_moduleName___ViewProtocol,
         dataSource: ___VARIABLE_moduleName___DataSourceProtocol) {
        
        self.interactor = interactor
        self.presenter = presenter
        self.view = view
        self.dataSource = dataSource
    }
    
    func viewToPresent() -> View {
        return view
    }
    
    func prepareToDeinit() {
        
    }
    
}
