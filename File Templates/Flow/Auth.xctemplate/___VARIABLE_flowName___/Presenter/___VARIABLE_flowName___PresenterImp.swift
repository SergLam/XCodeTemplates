//___FILEHEADER___

import Foundation
import UIKit

final class ___VARIABLE_flowName___PresenterImp: BasePresenter, ___VARIABLE_flowName___Presenter {
    
    weak var interactor: ___VARIABLE_flowName___Interactor?
    weak var viewController: ___VARIABLE_flowName___ViewController?
    
    var childFlowViewDict: [___VARIABLE_flowName___Option : UIView]?

    
    required init<ViewControllerType, InteractorType>(viewController: ViewControllerType, interactor: InteractorType) where ViewControllerType : ViewController, InteractorType : Interactor {
        super.init(viewController: viewController, interactor: interactor)
        self.viewController = viewController as? ___VARIABLE_flowName___ViewController
        self.interactor = interactor as? ___VARIABLE_flowName___Interactor
        childFlowViewDict = [___VARIABLE_flowName___Option : UIView]()
    }
    
    func configureView() {
        guard let childFlowViewDict = childFlowViewDict else { return }
        for key: ___VARIABLE_flowName___Option in childFlowViewDict.keys {
            guard let view = childFlowViewDict[key] else { return }
            switch key {
            case .internalAuth: do {
                    self.viewController?.addLoginPassView(view)
                }
            default:
                self.viewController?.addContentToStackView(view)
            }
        }
    }
}
