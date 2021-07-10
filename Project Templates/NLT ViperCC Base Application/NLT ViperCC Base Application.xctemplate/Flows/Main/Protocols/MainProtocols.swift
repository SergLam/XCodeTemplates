//___FILEHEADER___

import Foundation
import UIKit

protocol MainConfiguratorFactory: AnyObject {
    func makeMainConfigurator() -> MainConfigurator
}

protocol MainConfigurator: BaseConfigurator<MainViewControllerImp, MainPresenterImp, MainInteractorImp> {
}

protocol MainViewController: BaseViewController<MainPresenterImp> {
}

protocol MainPresenter: BasePresenter {
    var interactor: MainInteractor? { get set }
    var viewController: MainViewController? { get set }
    
    func signOutButtonPressed()
}

protocol MainInteractor: BaseInteractor<MainPresenterImp> {
    var onMainComplete: (() -> Void)? { get set }
    func signOutButtonPressed()
}
