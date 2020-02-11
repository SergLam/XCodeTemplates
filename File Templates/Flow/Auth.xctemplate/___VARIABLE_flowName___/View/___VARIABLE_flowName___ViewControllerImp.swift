//___FILEHEADER___

import Foundation
import UIKit

final class ___VARIABLE_flowName___ViewControllerImp: BaseViewController<___VARIABLE_flowName___PresenterImp>, ___VARIABLE_flowName___ViewController {
    
    @IBOutlet weak var servicesStackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var servicesAuthStackViewContainer: UIStackView!
    @IBOutlet weak var loginPassSignInViewContainer: UIView!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.configureView()
    }
    
    func addContentToStackView(_ child: UIView) {
        servicesAuthStackViewContainer.addArrangedSubview(child)
        servicesStackViewHeightConstraint.constant += child.frame.height + servicesAuthStackViewContainer.spacing
    }
    
    func addLoginPassView(_ child: UIView) {
        loginPassSignInViewContainer.addSubview(child)
    }
}
