//___FILEHEADER___

import Foundation
import UIKit

final class RestoreViewControllerImp: BaseViewController<RestorePresenterImp>, RestoreViewController {
    static var storyboardName: String {
        get {
            return "RestoreViewController"
        }
    }
    
    @IBOutlet weak var restoreFieldView: RestoreView!
    
    func fetchUserData() -> RestoreViewUserData? {
        return restoreFieldView.viewData
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        presenter?.sendButtonTouched()
    }
}
