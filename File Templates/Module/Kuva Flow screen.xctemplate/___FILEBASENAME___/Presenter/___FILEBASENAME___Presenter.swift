//___FILEHEADER___

import Foundation
import bwsc_ios

class ___VARIABLE_screenModuleName___Presenter<GenericView: ___VARIABLE_screenModuleName___ViewControllerProtocol>: ___VARIABLE_screenModuleName___PresenterProtocol {
    typealias View = GenericView
    typealias Model = ___VARIABLE_flowModel___
    
    var view: View?
    var model: Model?
    
    var bwc: BitcoreWalletClientProtocol
    
    var navigator: NavigatorProtocol
    
    required init(bitcoreWalletClient: BitcoreWalletClientProtocol,
                  navigator: NavigatorProtocol,
                  model: Model?) {
        self.bwc = bitcoreWalletClient
        self.navigator = navigator
        self.model = model
    }
    
    func backAction() {
        navigator.back()
    }
    
    func nextAction() {
        navigator.navigate(to: .<#Navigate to flow#>(flowDestination: <#Navigate to screen#>))
    }
    
}
