//___FILEHEADER___

import Foundation
import UIKit
import bwsc_ios

class ___VARIABLE_screenModuleName___Builder: BuilderProtocol {
    
    typealias Navigator = ___VARIABLE_flowName___Navigator
    typealias Model = ___VARIABLE_flowModel___
    
    func build(with navigator: ___VARIABLE_flowName___Navigator, model: Model?) -> UIViewController {
        let bwc = BitcoreWalletClient.shared
        
        let view = ___VARIABLE_screenModuleName___ViewController()
        let presenter = ___VARIABLE_screenModuleName___Presenter<___VARIABLE_screenModuleName___ViewController>(bitcoreWalletClient: bwc,
                                                          navigator: navigator,
                                                          model: model)
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
