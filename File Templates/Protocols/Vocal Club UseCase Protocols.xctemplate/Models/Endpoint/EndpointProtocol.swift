//
//  EndpointProtocol.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import Alamofire

enum RequestType {
    case dataTask
    case uploadTask
    case downloadTask
}

protocol EndpointProtocol {
    
    /// Task to do
    var requestType: RequestType { get }
    
    /// Endpoint path.
    var path: String { get }
    
    /// HTTP method.
    var method: HTTPMethod { get }
    
    /// Data to send
    var data: Any? { get }
    
    /// Parameters encoder.
    var encoder: ParameterEncoding { get }
    
    /// Request headers.
    var headers: HTTPHeaders? { get set }
    
    /// Adds to Endpoint HTTPHeaders. If headers do not exist – creates headers instance
    /// - Parameter headersToAdd: headers that have to been added to Headers list
    mutating func addHeaders(_ headersToAdd: [HTTPHeader])
    
}

extension EndpointProtocol {
    
    mutating func addHeaders(_ headersToAdd: [HTTPHeader]) {
        if var unwrapedHeaders = self.headers {
            headersToAdd.forEach { unwrapedHeaders.add($0) }
        } else {
            headers = HTTPHeaders(headersToAdd)
        }
    }
    
}
