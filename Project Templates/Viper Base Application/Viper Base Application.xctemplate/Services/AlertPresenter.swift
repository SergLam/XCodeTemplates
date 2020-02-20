//___FILEHEADER___

import SnapKit
import UIKit

protocol ProfilePhotoPickerActionSheetDelegate: class {
    
    func didTapTakeAPhoto()
    func didTapSelectPhoto()
}

protocol EventPhotoPickerActionSheetDelegate: class {
    
    func didTapTakeAPhoto()
    func didTapSelectPhoto()
    func didTapDeletePhoto()
}

final class AlertPresenter {
    
    weak var profilePickerDelegate: ProfilePhotoPickerActionSheetDelegate?
    
    // MARK: - Error alert
    static func showErrorAlert(at vc: UIViewController, errorMessgage: String) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Localizable.error(), message: errorMessgage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: Localizable.ok(), style: .default, handler: { _ in
                let error = AuthError.serverError(failureReason: errorMessgage)
                AuthError.handleError(error: error)
            })
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Error alert with closure
    static func showErrorAlertWithHandler(at vc: UIViewController, errorMessgage: String, handler: ((UIAlertAction) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Localizable.error(), message: errorMessgage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: Localizable.ok(), style: .default, handler: handler)
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Permission denied alert
    static func showPermissionDeniedAlert(at vc: UIViewController, errorMessage: String, cancelClosure: @escaping VoidClosure) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Localizable.error(), message: errorMessage, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: Localizable.cancel(), style: .cancel, handler: { _ in
                cancelClosure()
            })
            let openSettignsAction = UIAlertAction(title: Localizable.appSettings(), style: .default) { _ in
                guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(settingsURL)
            }
            alert.addAction(cancelAction)
            alert.addAction(openSettignsAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Success alert
    static func showSuccessAlert(at vc: UIViewController, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Localizable.success(), message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: Localizable.ok(), style: .default, handler: handler)
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Log out alert
    static func showLogOutAlert(at vc: UIViewController,
                                logOutClosure: @escaping VoidClosure) {
        DispatchQueue.main.async {
            let title = Localizable.appName()
            let message = Localizable.myProfileLogOutText()
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let logOutAction = UIAlertAction(title: Localizable.myProfileLogOutTitle(), style: .default) { _ in
                logOutClosure()
            }
            let cancelAction = UIAlertAction(title: Localizable.cancel(), style: .default) { _ in
                alert.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(logOutAction)
            alert.addAction(cancelAction)
            alert.preferredAction = logOutAction
            
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Todo alert
    static func showTodoAlert(at vc: UIViewController, messgage: String, handler: ((UIAlertAction) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Localizable.todo(), message: messgage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: Localizable.ok(), style: .default, handler: handler)
            alert.addAction(okAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Image picker alert
    func showImagePickerAlert(at vc: UIViewController, title: String) {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
            let takeAPhotoAction = UIAlertAction(title: Localizable.imageAlertTakePhoto(), style: .default) { [unowned self] _ in
                self.profilePickerDelegate?.didTapTakeAPhoto()
            }
            let selectImageAction = UIAlertAction(title: Localizable.imageAlertSelectPhoto(), style: .default) { [unowned self] _ in
                self.profilePickerDelegate?.didTapSelectPhoto()
            }
            let cancelAction = UIAlertAction(title: Localizable.cancel(), style: .cancel) { _ in
                alert.dismiss(animated: true, completion: nil)
            }
            let actions = [takeAPhotoAction, selectImageAction, cancelAction]
            actions.forEach { alert.addAction($0) }
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Date picker alert
    static func showDatePickerAlert(at vc: UIViewController, title: String, doneClosure: @escaping DateClosure) {
        
        DispatchQueue.main.async {
            
            let myDatePicker: UIDatePicker = UIDatePicker()
            myDatePicker.datePickerMode = .date
            myDatePicker.timeZone = NSTimeZone.local
            
            let currentDate: Date = Date()
            myDatePicker.minimumDate = currentDate
            myDatePicker.maximumDate = currentDate.addingTimeInterval(AppConstants.eventMaxDuration)
            
            myDatePicker.frame = CGRect(x: 10, y: 30, width: 250, height: 250)
            let alertController: UIAlertController = UIAlertController(title: title, message: "\n\n\n\n\n\n\n\n\n\n\n\n\n",
                                                                       preferredStyle: .alert)
            
            alertController.view.addSubview(myDatePicker)
            let selectAction: UIAlertAction = UIAlertAction(title: Localizable.ok(), style: .default, handler: { _ in
                doneClosure(myDatePicker.date)
            })
            let cancelAction: UIAlertAction = UIAlertAction(title: Localizable.cancel(), style: .cancel, handler: nil)
            alertController.addAction(selectAction)
            alertController.addAction(cancelAction)
            vc.present(alertController, animated: true, completion: nil)
        }
        
    }
    
}
