//
//  RequestPerformableProtocol.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import Alamofire

/// Completion that process NetworkDataPacket
typealias NetworkRouterCompletion = (NetworkResponse) -> Void

protocol RequestPerformableProtocol: class {
    
    func performRequest(endpoint: EndpointProtocol, completion: @escaping NetworkRouterCompletion) -> RequestModel?
    
    func cancelRequest(_ request: RequestModel)
    
}
