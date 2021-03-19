//___FILEHEADER___

import Foundation
import UIKit

final class ___VARIABLE_screenModuleName___Builder: BuilderProtocol {
    
    typealias FlowResult = ___VARIABLE_screenModuleName___FlowResult
    
    func build(errorHandlingService: ErrorsHandlingServiceProtocol,
               storage: StorageMementoProtocol,
               apiClient: APIClientProtocol,
               onFinish: @escaping (FlowResult) -> Void) -> UIViewController {
        
        let view = ___VARIABLE_screenModuleName___ViewController.instantiate()
        let factory = ___VARIABLE_screenModuleName___Factory(apiClient: apiClient)
        
        let presenter = ___VARIABLE_screenModuleName___Presenter<___VARIABLE_screenModuleName___ViewController, ___VARIABLE_screenModuleName___Factory>(view: view,
                                                                                                                                                        useCaseFactory: factory,
                                                                                                                                                        errorHandler: errorHandlingService,
                                                                                                                                                        storage: storage,
                                                                                                                                                        apiClient: apiClient,
                                                                                                                                                        onFinish: onFinish)
        
        view.presenter = presenter
        
        return view
    }
}
