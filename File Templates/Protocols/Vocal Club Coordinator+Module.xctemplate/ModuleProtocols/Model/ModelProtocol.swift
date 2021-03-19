//
//  ModelProtocol.swift
//  VocalClub
//
//  Created by NLT on 10/20/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import Moya

public protocol ModelProtocol: Codable {}

extension ModelProtocol {
    typealias Model = ModelProtocol
}

public class BaseModel: ModelProtocol {
    
}

extension BaseModel: JSONAble {
    
    public func toMultipartData() -> [Moya.MultipartFormData]? {
        return nil
    }
    
}
