//
//  NetworkChainControllersMementoProtocol.swift
//  VocalClub
//
//  Created by Serg Liamthev on 11.03.2021.
//  Copyright © 2021 VocalClub. All rights reserved.
//

import Foundation

protocol NetworkChainControllersMementoProtocol: class {
    
    // MARK: - Network layers
    var networkLayer: NetworkLayerProtocol { get set }
    var accessTokenController: AuthTokenControllerProtocol { get set }
    var nominatimLayer: NetworkLayerProtocol { get set }
    
    var networkObserver: NetworkStateObserverProtocol { get set }
    var allowedNetworkAccess: NetworkDataUsageOption { get set }
    
    // MARK: - Layers extraction
    func configureChain(_ chain: [NetworkChainControllers]) -> RequestPerformableProtocol
    
    func fullNetworkChain() -> RequestPerformableProtocol
    
    func unauthorizedNetworkChain() -> RequestPerformableProtocol
    
    func nominatimNetworkChain() -> RequestPerformableProtocol
    
    // MARK: - Network access
    func changeURLSessionConfiguration(for selectedDataTransferOption: NetworkDataUsageOption)
    
    func notifyAboutNetworkAviabilityChange(of type: WirelessNetworkConnectionType, isAvailable: Bool)
}
