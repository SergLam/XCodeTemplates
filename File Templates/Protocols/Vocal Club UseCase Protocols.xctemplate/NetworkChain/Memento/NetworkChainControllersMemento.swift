//
//  NetworkChainControllersMemento.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation

enum NetworkChainControllers: Int {
    
    case networkLayer = 0
    case authLayer
    case nominatimLayer
}

final class NetworkChainControllersMemento: NetworkChainControllersMementoProtocol {
    
    var networkObserver: NetworkStateObserverProtocol = NetworkStateObserver()
    lazy var allowedNetworkAccess: NetworkDataUsageOption = NetworkDataUsageOption.load(networkLayer.configuration.storage.userDefaults) ?? .mobileAndWifi
    
    var networkLayer: NetworkLayerProtocol
    var accessTokenController: AuthTokenControllerProtocol
    var nominatimLayer: NetworkLayerProtocol
    
    // MARK: - Life cycle
    init(networkLayer: NetworkLayerProtocol,
         accessTokenController: AuthTokenControllerProtocol,
         nominatimLayer: NetworkLayerProtocol) {
        
        self.networkLayer = networkLayer
        self.accessTokenController = accessTokenController
        self.nominatimLayer = nominatimLayer
        
        networkObserver.delegate = self
        networkObserver.startNetworkObserving(of: .wifi)
        networkObserver.startNetworkObserving(of: .cellular)
    }
    
    func configureChain(_ chain: [NetworkChainControllers]) -> RequestPerformableProtocol {
        
        var outputItems: [RequestPerformableProtocol] = []
        
        for item in chain.reversed() {
            switch item {
            case .networkLayer:
                outputItems.append(self.networkLayer)
                
            case .nominatimLayer:
                outputItems.append(self.nominatimLayer)
                
            case .authLayer:
                guard let lastItem = outputItems.last else {
                    return self.networkLayer
                }
                let output = AuthInterceptor(output: lastItem,
                                             authTokenController: self.accessTokenController)
                outputItems.append(output)
            }
        }
        
        if let firstOutput = outputItems.last {
            return firstOutput
        } else {
            return self.networkLayer
        }
    }
        
    func fullNetworkChain() -> RequestPerformableProtocol {
        return configureChain([.authLayer, .networkLayer])
    }
    
    func unauthorizedNetworkChain() -> RequestPerformableProtocol {
        return configureChain([.networkLayer])
    }
    
    func nominatimNetworkChain() -> RequestPerformableProtocol {
        return configureChain([.nominatimLayer])
    }
    
    func changeURLSessionConfiguration(for selectedDataTransferOption: NetworkDataUsageOption) {
        
        networkLayer.changeURLSessionConfiguration(for: selectedDataTransferOption)
        nominatimLayer.changeURLSessionConfiguration(for: selectedDataTransferOption)
        accessTokenController.networkLayer.changeURLSessionConfiguration(for: selectedDataTransferOption)
    }
    
    func notifyAboutNetworkAviabilityChange(of type: WirelessNetworkConnectionType, isAvailable: Bool) {
        
        networkLayer.networkAviabilityChange(of: type, isAvailable: isAvailable)
        nominatimLayer.networkAviabilityChange(of: type, isAvailable: isAvailable)
        accessTokenController.networkLayer.networkAviabilityChange(of: type, isAvailable: isAvailable)
    }
    
}

// MARK: - NetworkStateObserverDelegate
extension NetworkChainControllersMemento: NetworkStateObserverDelegate {
    
    func didDetectNetworkStateChange(isAvailable: Bool) {
        // NOTE: - Not used here
    }
    
    func didDetectWirelessNetworkStateChange(of type: WirelessNetworkConnectionType, isAvailable: Bool) {
        
        notifyAboutNetworkAviabilityChange(of: type, isAvailable: isAvailable)
    }
    
}
