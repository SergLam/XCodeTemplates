//___FILEHEADER___

import UIKit

class ___VARIABLE_moduleName___ModuleConfigurator: ModuleConfigurator {
    
    typealias ModuleType = ___VARIABLE_moduleName___ModuleProtocol
    
    class func makeModule() -> ___VARIABLE_moduleName___ModuleProtocol {
        let interactor = ___VARIABLE_moduleName___Interactor()
        let presenter = ___VARIABLE_moduleName___Presenter()
        
        let view = ___VARIABLE_moduleName___VC()
        
        let dataSource = ___VARIABLE_moduleName___DataSource()
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.dataSource = dataSource
        
        view.presenter = presenter
        view.animator = animator
        view.dataSource = dataSource

        let module = ___VARIABLE_moduleName___Module(interactor: interactor,
                                                     presenter: presenter,
                                                     view: view,
                                                     dataSource: dataSource)
        
        presenter.module = module
        
        return module
    }
    
}
