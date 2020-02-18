//___FILEHEADER___

import Foundation
import UIKit

protocol BaseViewControllerProtocol: UIViewController { }

protocol ViewController: BaseViewControllerProtocol {
    associatedtype PresenterType = Presenter
    var presenter: PresenterType? { get set }
}
