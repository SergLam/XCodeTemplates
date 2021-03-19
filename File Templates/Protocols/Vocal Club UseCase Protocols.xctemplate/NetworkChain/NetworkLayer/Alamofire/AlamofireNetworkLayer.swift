//
//  NetworkLayer.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import Alamofire

final class AlamofireNetworkLayer: NetworkLayerProtocol {
    
    let networkQueue = DispatchQueue(label: "com.vocalclub.API.response", attributes: .concurrent)
    
    var configuration: APIClientConfiguration
    
    var allowedNetworkAccess: NetworkDataUsageOption
    var availableNetworkConnectionType: Set<WirelessNetworkConnectionType> = [.cellular, .wifi]
    var networkConnectionSyncQueue: DispatchQueue = DispatchQueue(label: "\(Environment.bundleId).connection-sync.\(UUID().uuidString)", qos: .userInteractive, attributes: [], autoreleaseFrequency: .workItem, target: nil)
    
    lazy var session: Alamofire.Session = CustomAlamofireSession.sessionInstance(isAllowedMobileAccess: configuration.isAllowedMobileAccess)
    
    required init(configuration: APIClientConfiguration) {
        self.configuration = configuration
        self.allowedNetworkAccess = NetworkDataUsageOption.load(configuration.storage.userDefaults) ?? .mobileAndWifi
    }
    
    func performRequest(endpoint: EndpointProtocol, completion: @escaping NetworkRouterCompletion) -> RequestModel? {
        let request: Request? = buildRequest(with: endpoint) { response in
            completion(response)
        }
        
        let model = RequestModel()
        model.alamofireRequest = request
        return model
    }
    
    func cancelRequest(_ request: RequestModel) {
        request.cancelTask()
    }
    
    func buildRequest(with endpoint: EndpointProtocol,
                      completion: @escaping NetworkRouterCompletion) -> Request? {
        let path = configuration.endpoint + endpoint.path
        switch endpoint.requestType {
        case .dataTask:
            if endpoint.data == nil {
                return dataRequest(with: endpoint, parameters: nil, path: path, completion: { response in
                    completion(response)
                })
            } else if let parameters = endpoint.data as? [String: Any] {
                return dataRequest(with: endpoint, parameters: parameters, path: path, completion: { response in
                    completion(response)
                })
            }
        case .uploadTask:
            
            guard shouldAllowHeavyNetworkOperation() else {
                let response: NetworkResponse = NetworkResponse.wifiRequiredResponse()
                completion(response)
                return nil
            }
            if let data = endpoint.data as? Data {
                return uploadTask(with: endpoint, data: data, path: path, completion: { response in
                    completion(response)
                })
            }
        case .downloadTask:
            
            guard shouldAllowHeavyNetworkOperation() else {
                let response: NetworkResponse = NetworkResponse.wifiRequiredResponse()
                completion(response)
                return nil
            }
            if endpoint.data == nil {
                return downloadTask(with: endpoint, parameters: nil, path: path, completion: { response in
                    completion(response)
                })
            } else if let parameters = endpoint.data as? [String: Any] {
                return downloadTask(with: endpoint, parameters: parameters, path: path, completion: { response in
                    completion(response)
                })
            }
        }
        return nil
    }
    
    func dataRequest(with endpoint: EndpointProtocol,
                     parameters: [String: Any]?,
                     path: String,
                     completion: @escaping NetworkRouterCompletion) -> Request {
        let request = session.request(path,
                                      method: endpoint.method,
                                      parameters: parameters,
                                      encoding: endpoint.encoder,
                                      headers: endpoint.headers)
        request.responseJSON(queue: networkQueue) { response in
            completion(self.buildNetworkResponse(response))
        }
        return request
    }
    
    func uploadTask(with endpoint: EndpointProtocol,
                    data: Data,
                    path: String,
                    completion: @escaping NetworkRouterCompletion) -> Request {
        let request = session.upload(data,
                                     to: path,
                                     headers: endpoint.headers)
        request.responseJSON(queue: networkQueue) { response in
            completion(self.buildNetworkResponse(response))
        }
        return request
    }
    
    func downloadTask(with endpoint: EndpointProtocol,
                      parameters: [String: Any]?,
                      path: String,
                      completion: @escaping NetworkRouterCompletion) -> Request {
        let requset = session.download(path,
                                       parameters: parameters,
                                       encoding: endpoint.encoder,
                                       headers: endpoint.headers)
        requset.responseJSON(queue: networkQueue) { response in
            completion(self.buildNetworkResponse(response))
        }
        return requset
    }
    
    // MARK: - Response building
    func buildNetworkResponse(_ response: AFDataResponse<Any>) -> NetworkResponse {
        
        let error: Error? = response.error
        
        if let status = response.response?.statusCode,
           !((APIClient.successStatusCodes).contains(status)) {
            // TODO: Handle error
        }
        let networkResponse = NetworkResponse(data: response.data,
                                              response: response.value,
                                              error: error,
                                              status: response.response?.statusCode)
        return networkResponse
    }
    
    func buildNetworkResponse(_ response: AFDownloadResponse<Any>) -> NetworkResponse {
        
        let error: Error? = response.error
        
        if let status = response.response?.statusCode,
           !((APIClient.successStatusCodes).contains(status)) {
            // TODO: Handle error
        }
        let networkResponse = NetworkResponse(data: response.resumeData,
                                              response: response.value,
                                              error: error,
                                              status: response.response?.statusCode)
        return networkResponse
    }
    
}

// MARK: - NetworkLayerProtocol
extension AlamofireNetworkLayer {
    
    func cancelAllRequests() {
        
        session.cancelAllRequests()
    }
    
    func changeURLSessionConfiguration(for selectedDataTransferOption: NetworkDataUsageOption){
        
        allowedNetworkAccess = selectedDataTransferOption
        let isAllowMobile: Bool = selectedDataTransferOption == .mobileAndWifi
        session = CustomAlamofireSession.sessionInstance(isAllowedMobileAccess: isAllowMobile)
    }
    
    func networkAviabilityChange(of type: WirelessNetworkConnectionType, isAvailable: Bool) {
        
        switch isAvailable {
        case true:
            networkConnectionSyncQueue.async { [weak self] in
                self?.availableNetworkConnectionType.insert(type)
            }
            
        case false:
            networkConnectionSyncQueue.async { [weak self] in
                self?.availableNetworkConnectionType.remove(type)
            }
        }
    }
    
    func shouldAllowHeavyNetworkOperation() -> Bool {
        
        return allowedNetworkAccess.shouldAllowRequestExecution(for: availableNetworkConnectionType)
    }
    
}
