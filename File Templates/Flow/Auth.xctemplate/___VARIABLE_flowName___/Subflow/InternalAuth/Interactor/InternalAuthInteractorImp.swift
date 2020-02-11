//___FILEHEADER___

import Foundation

final class InternalAuthInteractorImp: BaseInteractor<InternalAuthPresenterImp>, InternalAuthInteractor {
    
    var onStartRestoreFlow: (() -> Void)?
    
    var onStartSignUpFlow: (() -> Void)?
    
	var onInternalAuthComplete: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)?
    
    func signIn(with userData: AuthLogPassUserData) {
        let user = ___VARIABLE_flowName___UserImp(authOption: .internalAuth, email: userData.email)
        guard let onInternalAuthComplete = onInternalAuthComplete else { return }
        onInternalAuthComplete(user)
    }
    
    func signUp() {
        guard let onStartSignUpFlow = onStartSignUpFlow else  { return }
        onStartSignUpFlow()
    }
    
    func restore() {
        guard let onStartRestoreFlow = onStartRestoreFlow else  { return }
        onStartRestoreFlow()
    }
}
