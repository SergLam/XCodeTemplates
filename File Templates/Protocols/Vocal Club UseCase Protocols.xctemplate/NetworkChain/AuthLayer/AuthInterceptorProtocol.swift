//
//  AuthInterceptorProtocol.swift
//  VocalClub
//
//  Created by NLT on 12/1/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import Alamofire

protocol AuthInterceptorProtocol: RequestPerformableProtocol, RequestPerformableOutputProtocol {
    
    var authTokenController: AuthTokenControllerProtocol { get set }
    
    init(output: RequestPerformableProtocol,
         authTokenController: AuthTokenControllerProtocol)
    
}

extension AuthInterceptorProtocol {
    
    func cancelRequest(_ request: RequestModel) {
        output.cancelRequest(request)
    }
    
}
