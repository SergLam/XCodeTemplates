//
//  AlamofireLogger.swift
//  VocalClub
//
//  Created by Serg Liamthev on 25.01.2021.
//  Copyright © 2021 VocalClub. All rights reserved.
//

import Alamofire
import Foundation

final class AlamofireLogger: Alamofire.EventMonitor {
    
    let queue = DispatchQueue(label: "com.nlt.vocalclub.afnetwork.logger")
    
    func requestDidFinish(_ request: Request) {
        
        let dateString: String = DateFormatterService.getISO8601DebugTimeStamp(from: Date())
        print(dateString, "REQUEST:", request.description, separator: "\n", terminator: "\n\n")
        if let httpRequest = request.request {
            print(dateString, "REQUEST HEADERS:", httpRequest.headers, separator: "\n", terminator: "\n\n")
            if let body = httpRequest.httpBody, let json = body.jsonString {
                print(dateString, "REQUEST BODY:", json, separator: "\n", terminator: "\n\n")
            }
            
        }
        
    }
    
    func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>) {
        
        let dateString: String = DateFormatterService.getISO8601DebugTimeStamp(from: Date())
        if let url = response.request?.url?.absoluteString {
            print(dateString, "RESPONSE:", url, separator: "\n", terminator: "\n\n")
        }
        
        if let statusCode = response.response?.statusCode {
            print(dateString, "STATUS CODE:", statusCode, separator: "\n", terminator: "\n\n")
        }
       
        if let headers = response.response?.allHeaderFields.jsonString {
            print(dateString, "HEADERS:", headers, separator: "\n", terminator: "\n\n")
        }
        
        guard let data = response.data else {
            return
        }
        if let json = try? JSONSerialization
            .jsonObject(with: data, options: .mutableContainers) {
            print(dateString, "RESPONSE BODY:", json, separator: "\n", terminator: "\n\n")
            
        } else {
            // NOTE: - For cases while backend return single-value response, e.g. integer value, without JSON brackets
            let responseString = String(decoding: data, as: UTF8.self)
            print(dateString, "RESPONSE BODY:", responseString, separator: "\n", terminator: "\n\n")
        }
    }
    
}
