//
//  UseCaseProtocol.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation

import Alamofire

protocol UseCaseProtocol: UseCaseExecutable {
    
    associatedtype SuccessModel: SuccessModelProtocol
    
    var networkChain: RequestPerformableProtocol? { get set }
    
    var request: RequestModel? { get set }
    
    var decoder: JSONDecoder { get set }
    var encoder: JSONEncoder { get set }
    
    var onSuccess: ((SuccessModel) -> Void) { get set }
    var onFailure: ((Error) -> Void) { get set }
    
    func handleNetworkError(error: Error)
    func handleParseModelError()
    
}

extension UseCaseProtocol {
    
    func cancelRequest() {
        guard let unwrapedRequest = request else {
            return
        }
        networkChain?.cancelRequest(unwrapedRequest)
    }
    
    func handleNetworkError(error: Error) {
        onFailure(error)
    }
    
    func handleParseModelError() {
        onFailure(APIError.parsingError)
    }
    
}
