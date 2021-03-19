//___FILEHEADER___

import Foundation

final class ___VARIABLE_screenModuleName___Presenter<GenericView: ___VARIABLE_screenModuleName___ViewControllerProtocol, GenericFactory: ___VARIABLE_screenModuleName___FactoryProtocol>: ___VARIABLE_screenModuleName___PresenterProtocol {
    
    typealias View = GenericView
    typealias Factory = GenericFactory
    typealias FlowResult = ___VARIABLE_screenModuleName___FlowResult

    weak var view: View?
    var viewState: ViewControllerState?
    var useCaseFactory: Factory
    var errorHandler: ErrorsHandlingServiceProtocol
    var storage: StorageMementoProtocol
    var api: APIClientProtocol
    var onFinish: ((FlowResult) -> Void)
    
    required init(view: View?,
                  useCaseFactory: Factory,
                  errorHandler: ErrorsHandlingServiceProtocol,
                  storage: StorageMementoProtocol,
                  apiClient: APIClientProtocol,
                  onFinish: @escaping (FlowResult) -> Void) {
        
        self.view = view
        self.useCaseFactory = useCaseFactory
        self.errorHandler = errorHandler
        self.storage = storage
        self.api = apiClient
        self.onFinish = onFinish
    }
    
}
