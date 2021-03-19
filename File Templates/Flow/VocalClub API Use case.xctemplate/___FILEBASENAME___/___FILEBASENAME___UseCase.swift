//___FILEHEADER___

import Alamofire
import Foundation

public final class ___VARIABLE_useCaseName___UseCase: ___VARIABLE_useCaseName___UseCaseProtocol {
    
    public var accessTokenRequired: Bool {
       
        return true
    }
    
    <#Model variables#>
    
    internal var networkChain: RequestPerformableProtocol?
    internal var request: RequestModel?
    
    var decoder: JSONDecoder = JSONDecoder()
    var encoder: JSONEncoder = JSONEncoder()
    
    public var onSuccess: ((___VARIABLE_useCaseName___SuccessModel) -> Void)
    public var onFailure: ((Error) -> Void)
    public var onFinished: (() -> Void)?
    
    public required init(<#Model variables#>,
                         onSuccess: @escaping (___VARIABLE_useCaseName___SuccessModel) -> Void,
                         onFailure: @escaping (Error) -> Void) {
        
        self.<#Model variables#> = <#Model variables#>
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }
    
    func execute(networkChainMemento: NetworkChainControllersMemento, onFinished: @escaping () -> Void) {
        
        self.onFinished = onFinished
        // Select proper network chain
        self.networkChain = networkChainMemento.fullNetworkChain()
        
        let endpointDestination = ___VARIABLE_endpointDestinationName___Destination.<#Destination#>
        let endpoint = EndpointBuilder.buildEndpoint(with: endpointDestination)
        
        request = networkChain?.performRequest(endpoint: endpoint) { [weak self] response in
            
            if let error = response.error {
                self?.onFailure(error)
            } else {
                self?.parseResponse(data: response.data, value: response.response, status: response.status)
            }
            self?.onFinished?()
        }
    }
    
    private func parseResponse(data: Data?, value: Any?, status: Int?) {
        <#Response parsing#>
        //This is an example of response parsing
//        if let result = value as? Bool {
//            let successModel = SuccessModel(isExist: result)
//            onSuccess(successModel)
//            onFinished?()
//        } else {
//            onFailure(APIError.wronRequest)
//        }
        
    }
    
}
