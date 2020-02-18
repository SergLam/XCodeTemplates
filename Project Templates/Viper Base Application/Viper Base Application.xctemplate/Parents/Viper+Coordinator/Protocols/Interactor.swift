//___FILEHEADER___

import Foundation

protocol BaseInteractorProtocol: NSObject {
    func pressedBackButton()
}

protocol Interactor: BaseInteractorProtocol {
    associatedtype PresenterType = Presenter
    var presenter: PresenterType? { get set }
}
