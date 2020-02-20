//___FILEHEADER___

import Firebase
import FirebaseAuth
import Foundation
import GoogleSignIn

enum GoogleKeys: String {
    case reversedClientId = "com.googleusercontent.apps.25668880887-tqefbc28go9tpg63oci7vqlbo0kjiukn"
}

final class GoogleAuthorizationService: NSObject {
    
    private let decoder = JSONDecoder()
    
    private var googleCompletion: AuthClosure?
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func loginToGoogle(view: UIViewController, completion: @escaping AuthClosure) {
        
        googleCompletion = completion
        GIDSignIn.sharedInstance()?.presentingViewController = view
        logInWithGoogle()
    }
    
    private func logInWithGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    /**
     SignUp with Gmail to server
     */
    private func signUpGmail(request: AuthRequest,
                             credential: AuthCredential,
                             completion: @escaping AuthClosure) {
        
        RestAPI.request(.loginByProvider(request)) { [weak self] result in
            switch result {
                
            case .success(let response):
                do {
                    guard let user = try self?.decoder.decode(MyUserJSON.self, from: response.data) else {
                        let error = AuthError.serverError(failureReason: "Unable to parse response")
                        completion(.failure(error))
                        return
                    }
                    guard user.token != nil else {
                        let error = AuthError.emptyToken
                        completion(.failure(error))
                        return
                    }
                    UserDefaults.shared.accessToken = user.token
                    DataManager.shared.safeWrite(value: [MyUser(user: user)])
                    completion(.success((user)))
                   
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /**
    Link account with Gmail to server
    */
    func linkAccount(request: AuthRequest,
                     completion: @escaping AuthClosure) {
        RestAPI.request(.linkAccount(request)) { [weak self] result in
            switch result {
                
            case .success(let response):
                do {
                    guard let user = try self?.decoder.decode(MyUserJSON.self, from: response.data) else {
                        let error = AuthError.serverError(failureReason: "Unable to parse response")
                        completion(.failure(error))
                        return
                    }
                    guard user.token != nil else {
                        let error = AuthError.emptyToken
                        completion(.failure(error))
                        return
                    }
                    UserDefaults.shared.accessToken = user.token
                    DataManager.shared.updateCurrentUser(user)
                    completion(.success((user)))
                   
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func signUpGmailFirebase(credential: AuthCredential,
                                     completion: @escaping VoidResultClosure) {
        
        Auth.auth().signIn(with: credential) { _, error in
            guard let error = error else {
                completion(.success(()))
                return
            }
            completion(.failure(error))
        }
    }
    
}

// MARK: - GIDSignInDelegate
extension GoogleAuthorizationService: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            // Usually call when user cancel auth flow - we should not show error message in this case
            googleCompletion?(.failure(AuthError.noError))
            return
        }
        guard let authentication = user?.authentication else {
            googleCompletion?(.failure(AuthError.googleSignInFailure))
            return
        }
        
        let request = AuthRequest(type: .gmail, token: authentication.idToken)
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        guard let closure = googleCompletion else {
            ErrorLoggerService.logWithTrace("Closure was'nt provided")
            return
        }
        
        signUpGmail(request: request, credential: credential, completion: closure)
    }
    
    func logOut(_ completion: (() -> Void)? = nil) {
        GIDSignIn.sharedInstance().signOut()
    }
}
