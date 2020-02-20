//___FILEHEADER___

import Foundation

 enum RequestManagerError: Error, LocalizedError {
    
    case unknownError
    
    case userCredentialsIsEmpty
    case unableToConvertImage
    case unableToParse(object: String)
    case serverError(errorMessage: String)
    case offlineError
    
    case mandatoryUpdate
    
    var description: String {
        switch self {
        case .unknownError:
            return Localizable.errorUnknownError()
        case .userCredentialsIsEmpty:
            return Localizable.authErrorEmptyCredentials()
        case .unableToConvertImage:
            return Localizable.imageBase64ConvertError()
        case .serverError(let errorMessage):
            return errorMessage
        case .unableToParse(let object):
            return object
        case .offlineError:
            return Localizable.errorOffline()
        case .mandatoryUpdate:
            return Localizable.errorMandatoryUpdateMessage()
        }
    }
    
     var errorDescription: String? {
        return self.description
    }
    
}
