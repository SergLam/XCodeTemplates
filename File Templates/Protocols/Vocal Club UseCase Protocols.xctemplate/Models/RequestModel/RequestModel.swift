//
//  RequestModel.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import Alamofire

final class RequestModel {
    
    /// Task used in URLSession
    var urlRequest: URLSessionTask?
    
    /// Task used in alamofire
    var alamofireRequest: Request?
    
    func cancelTask() {
        alamofireRequest?.cancel()
        urlRequest?.cancel()
    }
    
}
