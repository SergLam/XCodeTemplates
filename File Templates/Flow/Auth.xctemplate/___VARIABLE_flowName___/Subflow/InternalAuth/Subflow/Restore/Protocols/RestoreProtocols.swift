//___FILEHEADER___
    
import Foundation
import UIKit

protocol RestoreConfiguratorFactory: class {
    func makeRestoreConfigurator() -> RestoreConfigurator
}

protocol RestoreConfigurator: BaseConfigurator<RestoreViewControllerImp, RestorePresenterImp, RestoreInteractorImp> {
}

protocol RestoreViewController: BaseViewController<RestorePresenterImp> {
    func fetchUserData() -> RestoreViewUserData?
}

protocol RestorePresenter: BasePresenter {
    var interactor: RestoreInteractor? { get set }
    var viewController: RestoreViewController? { get set }
    func sendButtonTouched()
}

protocol RestoreInteractor: BaseInteractor<RestorePresenterImp> {
    var onRestoreComplete: (() -> Void)? { get set }
    func restoreUser(data: RestoreViewUserData)
}
