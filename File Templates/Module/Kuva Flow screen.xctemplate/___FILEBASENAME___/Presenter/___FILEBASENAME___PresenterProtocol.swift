//___FILEHEADER___

import Foundation
import bwsc_ios

protocol ___VARIABLE_screenModuleName___PresenterProtocol: PresenterProtocol {
    
    associatedtype View: ___VARIABLE_screenModuleName___ViewControllerProtocol
    associatedtype Model: ModelProtocol
    
    var view: View? { get set }
    var model: Model? { get set }
    
    var navigator: NavigatorProtocol { get set }
    
    init(bitcoreWalletClient: BitcoreWalletClientProtocol,
         navigator: NavigatorProtocol,
         model: Model?)
    
    func backAction()
    
    func nextAction()
    
}
