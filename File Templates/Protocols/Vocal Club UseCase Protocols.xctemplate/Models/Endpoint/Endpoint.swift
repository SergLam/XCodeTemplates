//
//  Endpoint.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import Alamofire

struct Endpoint: EndpointProtocol {
    
    var requestType: RequestType
    
    var path: String
    
    var method: HTTPMethod
    
    var data: Any?
    
    var encoder: ParameterEncoding
    
    var headers: HTTPHeaders?
    
}
