//___FILEHEADER___

import Foundation
import UIKit

final class ___VARIABLE_moduleName___PresenterImp: BasePresenter, ___VARIABLE_moduleName___Presenter {
    
    var childFlowViewArray: [UIView]?
    weak var interactor: ___VARIABLE_moduleName___Interactor?
    weak var viewController: ___VARIABLE_moduleName___ViewController?
    
    required init<ViewControllerType, InteractorType>(viewController: ViewControllerType, interactor: InteractorType) where ViewControllerType : ViewController, InteractorType : Interactor {
        super.init(viewController: viewController, interactor: interactor)
        self.viewController = viewController as? ___VARIABLE_moduleName___ViewController
        self.interactor = interactor as? ___VARIABLE_moduleName___Interactor
        
        childFlowViewArray = [UIView]()
    }
    
    func configureView() {

    }
}
