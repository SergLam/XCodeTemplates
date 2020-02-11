//___FILEHEADER___

import Foundation

protocol ___VARIABLE_screenModuleName___ViewControllerProtocol: ViewProtocol {
    
    associatedtype Presenter: ___VARIABLE_screenModuleName___PresenterProtocol
    
    var presenter: Presenter? { get set }
    
    func showNoInternetConnectionWarning()
    
}
