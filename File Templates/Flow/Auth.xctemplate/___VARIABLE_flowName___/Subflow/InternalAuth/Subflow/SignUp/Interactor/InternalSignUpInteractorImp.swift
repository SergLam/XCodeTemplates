//___FILEHEADER___

import Foundation
import UIKit

final class InternalSignUpInteractorImp: BaseInteractor<InternalSignUpPresenterImp>, InternalSignUpInteractor {
    var finishInternalSignUpFlow: ((_ authUser: ___VARIABLE_flowName___User?) -> Void)?
    
    func registerUser(data: AuthLogPassUserData) {
        guard let finishInternalSignUpFlow = finishInternalSignUpFlow else { return }
        finishInternalSignUpFlow(___VARIABLE_flowName___UserImp(authOption: .internalAuth))
    }
}

