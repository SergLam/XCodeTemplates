//
//  EndpointDestinationProtocol.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Alamofire
import Foundation

protocol EndpointDestinationProtocol: EndpointProtocol {
    
    /// API version
    var apiVersion: String { get }
    
    /// Controller where request belongs to
    var controller: String { get }
    
}
