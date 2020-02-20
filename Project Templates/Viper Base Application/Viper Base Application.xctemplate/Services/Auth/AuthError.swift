//___FILEHEADER___

import Foundation

enum AuthError: Error, LocalizedError {
    
    case notFound
    case notAuthorized
    case unableToGetUserProfile
    case unableToLogOut
    
    case googleSignInFailure
    
    case serverError(failureReason: String)
    case emptyToken
    case emptyRefreshToken
    case emptyResponseValues
    
    case invalidPassword
    case emptyPassword
    
    case noError
    
    var description: String {
        switch self {
        case .notFound:
            return Localizable.authErrorNotFound()
            
        case .notAuthorized:
            return Localizable.authErrorNotAuthorized()
            
        case .unableToGetUserProfile:
            return Localizable.authErrorLoadProfile()
            
        case .unableToLogOut:
            return Localizable.authErrorUnableLogout()
            
        case .googleSignInFailure:
            return Localizable.authErrorGoogleSignIn()
            
        case .serverError(let failureReason):
            return failureReason
            
        case .emptyToken:
            return Localizable.authErrorEmptyToken()
            
        case .emptyRefreshToken:
            return Localizable.authErrorEmptyRefreshToken()
            
        case .emptyResponseValues:
            return Localizable.authErrorEmptyResponse()
            
        case .invalidPassword:
            return Localizable.authErrorInvalidPassword()
            
        case .emptyPassword:
            return Localizable.authErrorEmptyPassword()
            
        case .noError:
            return Localizable.authErrorNoError()
        }
    }
    
    var errorDescription: String? {
        return self.description
    }
    
    static func handleError(error: AuthError) {
        
        switch error {
        case .serverError(let failureReason):
            
            if failureReason == "User is Unauthorized!" {
                AppRouter.logOut()
            } else {
                break
            }
        default:
            break
        }
    }
    
}
