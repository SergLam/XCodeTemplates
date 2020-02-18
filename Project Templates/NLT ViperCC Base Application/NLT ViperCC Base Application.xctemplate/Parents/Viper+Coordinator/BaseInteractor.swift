//___FILEHEADER___

import Foundation

class BaseInteractor<PresenterType: Presenter>: NSObject, Interactor {
    
    weak var presenter: PresenterType?
    
    var onBackButtonPressed: (() -> Void)?
    
    func pressedBackButton() {
        guard let onBackButtonPressed = onBackButtonPressed else { return }
        onBackButtonPressed()
    }
}
