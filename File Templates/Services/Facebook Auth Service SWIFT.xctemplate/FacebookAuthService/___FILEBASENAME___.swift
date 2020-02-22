//___FILEHEADER___

import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import Foundation

// TODO: Insert your codable model here
typealias AuthClosure = (Swift.Result<String/*UserJSON*/, Error>) -> Void
typealias VoidResultClosure = (Swift.Result<Void, Error>) -> Void

final class FacebookAuthorizationService {
    
    private var authCompletion: AuthClosure?
    
    private let decoder = JSONDecoder()
    
    private let readPermissions: [Permission] = [.publicProfile, .email]
    
    func signInFacebook(view: UIViewController, completion: @escaping AuthClosure) {
        
        authCompletion = completion
        
        let loginManager = LoginManager()
        loginManager.logOut()
        
        loginManager.logIn(permissions: readPermissions, viewController: view) { [weak self] result in
            switch result {
            case .success:
                guard let weakSelf = self, let accessToken = AccessToken.current else {
                    completion(.failure(AuthError.unableToGetUserProfile))
                    return
                }
                
                weakSelf.signUpToFacebook(fbToken: accessToken.tokenString, completion: { result in
                    
                    switch result {
                    case .success(let user):
                        completion(.success((user)))
                        
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
                
            case .failed(let error):
                completion(.failure(error))
                
            case .cancelled:
                let error = AuthError.noError
                completion(.failure(error))
            }
        }
    }
    
    /**
     Sign in with Facebook token to server
     */
    private func signUpToFacebook(fbToken: String,
                                  completion: @escaping AuthClosure) {
        
//        // TODO: Perform request to your server in order to authorise user
//        // TODO: Replace AuthRequest with your codable model if needed
//
//        let request: AuthRequest = AuthRequest(type: .facebook, token: fbToken)
//
//        RestAPI.request(.loginByProvider(request)) { [weak self] result in
//            switch result {
//
//            case .success(let response):
//                do {
//                    // TODO: Parse server response here
//
//                    guard let user = try self?.decoder.decode(UserJSON.self, from: response.data) else {
//                        let error = AuthError.serverError(failureReason: "Unable to parse response")
//                        completion(.failure(error))
//                        return
//                    }
//                    guard user.token != nil else {
//                        let error = AuthError.emptyToken
//                        completion(.failure(error))
//                        return
//                    }
//                    UserDefaults.shared.accessToken = user.token
//                    DataManager.shared.safeWrite(value: [MyUser(user: user)])
//                    completion(.success((user)))
//
//                } catch {
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
    }
    
}
