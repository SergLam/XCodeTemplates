//
//  EndpointBuilderProtocol.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation

protocol EndpointBuilderProtocol: class {
    
    static func buildEndpoint(with destination: EndpointDestinationProtocol) -> EndpointProtocol
    
}

final class EndpointBuilder: EndpointBuilderProtocol {
    
    static func buildEndpoint(with destination: EndpointDestinationProtocol) -> EndpointProtocol {

        let endpoint = Endpoint(requestType: destination.requestType,
                                path: destination.controller + destination.apiVersion + destination.path,
                                method: destination.method,
                                data: destination.data,
                                encoder: destination.encoder,
                                headers: destination.headers)
        return endpoint
    }
    
}
