//
//  CreateGiftRequest.swift
//  GiftWishesiOS
//
//  Created by Serg Liamthev on 02.01.2020.
//  Copyright © 2020 Serg Liamtsev. All rights reserved.
//

import Moya
import UIKit

struct CreateGiftRequest: Decodable {
    
    var eventId: Int
    var name: String
    var link: String
    var price: Double
    var photo: UIImage
    var sizes: GiftSizesJSON
    
    enum ExternalCodingKeys: String, CodingKey {
        case gift = "gift"
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case eventId = "event_id"
        case name = "name"
        case link = "link"
        case price = "price"
        case photo = "photo"
        case sizes = "size"
    }
    
    init(eventId: Int,
         name: String,
         link: String,
         price: Double,
         photo: UIImage,
         sizes: GiftSizesJSON) {
        self.eventId = eventId
        self.name = name
        self.link = link
        self.price = price
        self.photo = photo
        self.sizes = sizes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        eventId = try container.decode(Int.self, forKey: .eventId)
        name = try container.decode(String.self, forKey: .name)
        link = try container.decode(String.self, forKey: .link)
        price = try container.decode(Double.self, forKey: .price)
        
        let imageBase64Str = try container.decode(String.self, forKey: .photo)
        photo = imageBase64Str.convertBase64ToImage() ?? UIImage()
        sizes = try container.decode(GiftSizesJSON.self, forKey: .sizes)
    }
    
}

// MARK: - Encodable
extension CreateGiftRequest: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(eventId, forKey: .eventId)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(link, forKey: .link)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(photo.base64String(), forKey: .photo)
        try container.encodeIfPresent(sizes, forKey: .sizes)
    }
    
}

// MARK: - JSONAble
extension CreateGiftRequest: JSONAble {
    
    typealias ReturnType = CreateGiftRequest
    
    func toJSON() -> [String: Any] {
        return [:]
    }
    
    func toMultipartData() -> [MultipartFormData]? {
        
        var multipartData = [Moya.MultipartFormData]()
        let keys = CodingKeys.allCases
        
        for key in keys {
            
            let formData: Moya.MultipartFormData
            
            switch key {
                
            case .eventId:
                guard let data = String(eventId).data(using: .utf8) else {
                    preconditionFailure("Unable to get data")
                }
                let name: String = "\(ExternalCodingKeys.gift.rawValue)[\(key.rawValue)]"
                formData = MultipartFormData(provider: .data(data), name: name)
                
            case .name:
                guard let data = name.data(using: .utf8) else {
                    preconditionFailure("Unable to get data")
                }
                let name: String = "\(ExternalCodingKeys.gift.rawValue)[\(key.rawValue)]"
                formData = MultipartFormData(provider: .data(data), name: name)
                
            case .link:
                guard let data = link.data(using: .utf8) else {
                    preconditionFailure("Unable to get data")
                }
                let name: String = "\(ExternalCodingKeys.gift.rawValue)[\(key.rawValue)]"
                formData = MultipartFormData(provider: .data(data), name: name)
                
            case .price:
                guard let data = String(price).data(using: .utf8) else {
                    preconditionFailure("Unable to get data")
                }
                let name: String = "\(ExternalCodingKeys.gift.rawValue)[\(key.rawValue)]"
                formData = MultipartFormData(provider: .data(data), name: name)
                
            case .photo:
                guard let imageData = photo.downScaleTo10Megabytes() else {
                    preconditionFailure("Unable to get data")
                }
                let name: String = "\(ExternalCodingKeys.gift.rawValue)[\(key.rawValue)]"
                formData = MultipartFormData(provider: .data(imageData), name: name, fileName: name, mimeType: "image/jpg")
            case .sizes:
                guard let data = sizes.toJSONString()?.data(using: .utf8) else {
                    preconditionFailure("Unable to get data")
                }
                let name: String = "\(ExternalCodingKeys.gift.rawValue)[\(key.rawValue)]"
                formData = MultipartFormData(provider: .data(data), name: name)
            }
            
            multipartData.append(formData)
        }
        return multipartData
    }
    
    static func fromJSON(_ dictionary: [AnyHashable: Any]) -> CreateGiftRequest? {
        return nil
    }
    
}
