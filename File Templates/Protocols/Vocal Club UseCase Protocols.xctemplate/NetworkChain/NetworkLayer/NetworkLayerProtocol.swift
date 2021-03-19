//
//  NetworkLayerProtocol.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkLayerProtocol: RequestPerformableProtocol {
    
    var configuration: APIClientConfiguration { get set }
    
    var session: Alamofire.Session { get set }
    
    var allowedNetworkAccess: NetworkDataUsageOption { get set }
    var availableNetworkConnectionType: Set<WirelessNetworkConnectionType> { get set }
    var networkConnectionSyncQueue: DispatchQueue { get set }
    
    init(configuration: APIClientConfiguration)
    
    func cancelAllRequests()
    
    func changeURLSessionConfiguration(for selectedDataTransferOption: NetworkDataUsageOption)
    
    func networkAviabilityChange(of type: WirelessNetworkConnectionType, isAvailable: Bool)
    
    func shouldAllowHeavyNetworkOperation() -> Bool
}
