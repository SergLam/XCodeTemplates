//___FILEHEADER___

import Foundation
import UIKit

class ___VARIABLE_screenModuleName___ViewController: UIViewController, ___VARIABLE_screenModuleName___ViewControllerProtocol, StatusBarProtocol {
    
    typealias Presenter = ___VARIABLE_screenModuleName___Presenter<___VARIABLE_screenModuleName___ViewController>
    
    var presenter: Presenter?
    
    @IBOutlet weak var statusBar: ___VARIABLE_flowName___StatusBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBar.delegate = self
    }
    
    func showNoInternetConnectionWarning() {
        
    }
    
    func backButtonAction() {
        presenter?.backAction()
    }
    
}
