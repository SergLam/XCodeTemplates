//___FILEHEADER___

import Foundation
import UIKit

final class MainViewControllerImp: BaseViewController<MainPresenterImp>, MainViewController {    
    @IBAction func signOutButtonAction(_ sender: Any) {
        presenter?.signOutButtonPressed()
    }
}
