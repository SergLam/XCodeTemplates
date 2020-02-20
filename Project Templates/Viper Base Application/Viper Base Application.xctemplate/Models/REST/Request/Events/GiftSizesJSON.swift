//
//  GiftSizesJSON.swift
//  GiftWishesiOS
//
//  Created by Serg Liamthev on 07.02.2020.
//  Copyright © 2020 Serg Liamtsev. All rights reserved.
//

import Moya
import UIKit

struct GiftSizesJSON: Decodable {
    
    var shoe: String
    var dress: String
    var pant: String
    var topDress: String
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case shoe = "shoe"
        case dress = "dress"
        case pant = "pant"
        case topDress = "top"
    }
    
    init(shoe: String, dress: String, pant: String, topDress: String) {
        self.shoe = shoe
        self.dress = dress
        self.pant = pant
        self.topDress = topDress
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        shoe = try container.decode(String.self, forKey: .shoe)
        dress = try container.decode(String.self, forKey: .dress)
        pant = try container.decode(String.self, forKey: .pant)
        topDress = try container.decode(String.self, forKey: .topDress)
    }
    
}

// MARK: - Encodable
extension GiftSizesJSON: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(shoe, forKey: .shoe)
        try container.encodeIfPresent(dress, forKey: .dress)
        try container.encodeIfPresent(pant, forKey: .pant)
        try container.encodeIfPresent(topDress, forKey: .topDress)
    }
    
}

// MARK: - JSONAble
extension GiftSizesJSON: JSONAble {
    
    typealias ReturnType = GiftSizesJSON
    
    func toJSON() -> [String: Any] {
        var result: [String: Any] = [:]
        result[CodingKeys.shoe.rawValue] = shoe
        result[CodingKeys.dress.rawValue] = dress
        result[CodingKeys.pant.rawValue] = pant
        result[CodingKeys.topDress.rawValue] = topDress
        return result
    }
    
    static func fromJSON(_ dictionary: [AnyHashable: Any]) -> GiftSizesJSON? {
        return nil
    }
    
    func toMultipartData() -> [Moya.MultipartFormData]? {
        
        let params = self.toJSON()
        var multipartData = [Moya.MultipartFormData]()
        for (key, value) in params {
            guard let str = value as? String, let data = str.data(using: .utf8) else {
                continue
            }
            let formData = Moya.MultipartFormData(provider: .data(data), name: key)
            multipartData.append(formData)
        }
        return multipartData
    }
    
}
