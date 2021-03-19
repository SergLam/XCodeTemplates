//___FILEHEADER___

import Foundation

protocol ___VARIABLE_useCaseName___UseCaseProtocol: UseCaseProtocol where SuccessModel == ___VARIABLE_useCaseName___SuccessModel {
    
    <#Model variables#>
    
    init(<#Model variables#>,
         onSuccess: @escaping (SuccessModel) -> Void,
         onFailure: @escaping (Error) -> Void)
    
}
