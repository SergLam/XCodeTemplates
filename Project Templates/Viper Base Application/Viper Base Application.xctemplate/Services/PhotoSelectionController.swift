//___FILEHEADER___

import AVFoundation
import Photos
import UIKit

protocol PhotoSelectionControllerDelegate: class {
    
    func photoSelectionCanceled()
    
    func didFailWithError(_ error: String)
    func didFailToGetPermission(_ message: String)
    
    func didUserSelectImage(_ image: UIImage)
    
    func didPhotoSelectionCompleted()
}

typealias ImageFetchClosure = (_ image: UIImage?) -> Void

final class PhotoSelectionController: NSObject {
    
    weak var delegate: PhotoSelectionControllerDelegate?
    
    private let phManager = PHCachingImageManager()
    
}

// MARK: - UINavigationControllerDelegate
extension PhotoSelectionController: UINavigationControllerDelegate {
    
    func checkCameraAccess(completion: @escaping (Bool) -> Void ) {
        guard AVCaptureDevice.default(for: .video) != nil else {
            delegate?.didFailWithError(Localizable.errorCameraNotAvailable())
            completion(false)
            return
        }
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied, .restricted:
            delegate?.didFailToGetPermission(Localizable.accessErrorCamera())
            completion(false)
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [unowned self] success in
                if !success {
                    self.delegate?.didFailToGetPermission(Localizable.accessErrorCamera())
                }
                completion(success)
            }
            
        @unknown default:
            ErrorLoggerService.logWithTrace("Unknown AVCaptureDevice authorizationStatus value")
        }
    }
    
    func checkPhotosAccess(completion: @escaping (Bool) -> Void ) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            delegate?.didFailToGetPermission(Localizable.accessErrorPhotos())
            completion(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [unowned self] status in
                switch status {
                case .authorized:
                    completion(true)
                case .denied, .restricted:
                    self.delegate?.didFailToGetPermission(Localizable.accessErrorPhotos())
                    completion(false)
                case .notDetermined:
                    ErrorLoggerService.logWithTrace("Check the logic above") // won't happen but still
                @unknown default:
                    ErrorLoggerService.logWithTrace("Unknown PHPhotoLibrary authorizationStatus value")
                }
            }
        @unknown default:
            ErrorLoggerService.logWithTrace("Unknown PHPhotoLibrary authorizationStatus value")
        }
    }
    
}

// MARK: - UIImagePickerControllerDelegate
extension PhotoSelectionController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        // NOTE: image captured by device camera do not have image URL
        handleCapturedImage(picker, info: info)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        delegate?.photoSelectionCanceled()
    }
    
    private func handleCapturedImage(_ picker: UIImagePickerController,
                                     info: [UIImagePickerController.InfoKey: Any]) {
        
        var selectedImage: UIImage?
        let editedImage = info[.editedImage] as? UIImage
        
        if editedImage?.jpegData(compressionQuality: 1.0) == nil {
            // Image was NOT edited
            guard let image = info[.originalImage] as? UIImage else {
                ErrorLoggerService.logWithTrace("Unable to get image")
                return
            }
            selectedImage = image
        } else {
            // Image was edited
            guard let image = info[.editedImage] as? UIImage else {
                ErrorLoggerService.logWithTrace("Unable to get image")
                return
            }
            selectedImage = image
        }
        guard let image = selectedImage else {
            ErrorLoggerService.logWithTrace("Image wasn't provided")
            return
        }
        
        delegate?.didUserSelectImage(image)
        picker.dismiss(animated: true) { [unowned self] in
            self.delegate?.didPhotoSelectionCompleted()
        }
        
    }
    
}
