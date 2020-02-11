//___FILEHEADER___

import Foundation
import FacebookLogin


final class FacebookAuthDelegateImp: NSObject, FacebookAuthDelegate {
    var facebookAuthComplete: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)?
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) { }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let result = result, let facebookAuthComplete = facebookAuthComplete else { return }
        if result.isCancelled { return }
        let authUser = ___VARIABLE_flowName___UserImp(authOption: .facebookAuth, accessData: result.token)
        facebookAuthComplete(authUser)
    }
}
