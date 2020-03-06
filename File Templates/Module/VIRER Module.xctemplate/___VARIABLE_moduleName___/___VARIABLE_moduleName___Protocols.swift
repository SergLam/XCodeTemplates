//___FILEHEADER___
    
import Foundation
import UIKit

protocol ___VARIABLE_moduleName___ModuleProtocol: Module {
    
    var interactor: ___VARIABLE_moduleName___InteractorProtocol { get set }
    var presenter: ___VARIABLE_moduleName___PresenterProtocol { get set }
    var view: ___VARIABLE_moduleName___ViewProtocol { get set }
    var dataSource: ___VARIABLE_moduleName___DataSourceProtocol { get set }
    
    // NOTE: Place module navigation closures here
    var onBackSelected: VoidClosure? { get set }
    
}

protocol ___VARIABLE_moduleName___ViewProtocol: View {
    
    var presenter: ___VARIABLE_moduleName___PresenterProtocol? { get set }
    var dataSource: ___VARIABLE_moduleName___DataSourceProtocol? { get }
    
    // Presenter -> view
    func didReceivedError(error: String)
}

protocol ___VARIABLE_moduleName___PresenterProtocol: Presenter {
    
    var interactor: ___VARIABLE_moduleName___InteractorProtocol? { get set }
    var view: ___VARIABLE_moduleName___ViewProtocol? { get set }
    var dataSource: ___VARIABLE_moduleName___DataSourceProtocol? { get }
    var module: ___VARIABLE_moduleName___ModuleProtocol? { get set }
    
    // NOTE: View -> Presenter actions
}

protocol ___VARIABLE_moduleName___InteractorProtocol: Interactor {
    
    var presenter: ___VARIABLE_moduleName___PresenterProtocol? { get set }
    // NOTE: - Place actions + services here (conformance to protocol)

}

protocol ___VARIABLE_moduleName___DataSourceProtocol: DataSource {
    // NOTE: - Place computed properties / getters / setters here
}
