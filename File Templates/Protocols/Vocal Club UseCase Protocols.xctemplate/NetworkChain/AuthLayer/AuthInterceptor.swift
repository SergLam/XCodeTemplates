//
//  AuthInterceptor.swift
//  VocalClub
//
//  Created by NLT on 12/1/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import Alamofire

final class AuthInterceptor: AuthInterceptorProtocol {
    
    var output: RequestPerformableProtocol
    
    var authTokenController: AuthTokenControllerProtocol
    
    required init(output: RequestPerformableProtocol,
                  authTokenController: AuthTokenControllerProtocol) {
        self.output = output
        self.authTokenController = authTokenController
    }
    
    func performRequest(endpoint: EndpointProtocol, completion: @escaping NetworkRouterCompletion) -> RequestModel? {
        guard let accessToken = authTokenController.getAccessToken(force: false) else {
            return nil
        }
        
        let token = "Bearer " + accessToken
        let header = HTTPHeader(name: "Authorization", value: token)
        
        var nEndpoint = endpoint
        nEndpoint.addHeaders([header])
        
        let request = output.performRequest(endpoint: nEndpoint) { response in
            if response.status == 401 {
                _ = self.authTokenController.getAccessToken(force: true)
            } else {
                completion(response)
            }
        }
        
        return request
    }
    
}
