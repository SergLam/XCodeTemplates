//___FILEHEADER___

import Foundation

final class RequestManager {
    
    static let decoder = JSONDecoder()
    
    static func getAppStatus(completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        
        API.request(.signIn) { result in
            switch result {
                
            case .success(let value):
                // TODO: Parse response
                break
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
