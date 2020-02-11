//___FILEHEADER___

import Foundation
import GoogleSignIn

final class GoogleAuthDelegateImp: NSObject, GoogleAuthDelegate {
    var googleAuthComplete: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let user = user, let googleAuthComplete = googleAuthComplete else { return }
        let authUser = ___VARIABLE_flowName___UserImp(authOption: .googleAuth, accessData: user, email: user.profile.email)
        googleAuthComplete(authUser)
    }
}
