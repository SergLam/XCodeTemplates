//
//  NetworkResponse.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation

/// Network response structure
public struct NetworkResponse {
    
    /// Network response data.
    var data: Data?
    
    /// URLResponse from network response
    var response: Any?
    
    /// Error from network response. nil if no error
    var error: Error?

    /// Responce status code
    var status: Int?
    
    static func wifiRequiredResponse() -> NetworkResponse {
        
        return NetworkResponse(data: nil, response: nil, error: APIError.wifiConnectionRequired, status: APIClient.wifiConnectionRequiredCode)
    }
    
}
