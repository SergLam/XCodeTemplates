//
//  CreateEventRequest.swift
//  GiftWishesiOS
//
//  Created by Serg Liamthev on 22.12.2019.
//  Copyright © 2019 Serg Liamtsev. All rights reserved.
//

import Moya
import UIKit

struct CreateEventRequest: Decodable {
    
    var title: String
    var startDate: Date
    var endDate: Date
    var description: String
    
    var photo: UIImage
    
    var gift: GiftAttributesJSON
    
    enum ExternalCodingKeys: String, CodingKey {
        case event = "event"
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case title = "title"
        case startDate = "start_date"
        case endDate = "end_date"
        case description = "description"
        case photo = "photo"
        case gift = "gifts_attributes"
    }
    
    init(title: String,
         startDate: Date,
         endDate: Date,
         description: String,
         photo: UIImage,
         gift: GiftAttributesJSON) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
        self.photo = photo
        self.gift = gift
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ExternalCodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .event)
        title = try nestedContainer.decode(String.self, forKey: .title)
        startDate = try nestedContainer.decode(Date.self, forKey: .startDate)
        endDate = try nestedContainer.decode(Date.self, forKey: .endDate)
        description = try nestedContainer.decode(String.self, forKey: .description)
        
        let imageBase64Str = try nestedContainer.decode(String.self, forKey: .photo)
        photo = imageBase64Str.convertBase64ToImage() ?? UIImage()
        gift = try nestedContainer.decode(GiftAttributesJSON.self, forKey: .gift)
    }
    
}

// MARK: - Encodable
extension CreateEventRequest: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ExternalCodingKeys.self)
        var nestedContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .event)
        try nestedContainer.encodeIfPresent(title, forKey: .title)
        try nestedContainer.encodeIfPresent(startDate, forKey: .startDate)
        try nestedContainer.encodeIfPresent(endDate, forKey: .endDate)
        try nestedContainer.encodeIfPresent(description, forKey: .description)
        try nestedContainer.encodeIfPresent(photo.base64String(), forKey: .photo)
        try nestedContainer.encodeIfPresent(gift, forKey: .gift)
    }
    
}

// MARK: - Encodable
extension CreateEventRequest: JSONAble {

    typealias ReturnType = CreateEventRequest
    
    func toJSON() -> [String: Any] {
        var result: [String: Any] = [:]
        result[CodingKeys.title.rawValue] = title
        result[CodingKeys.startDate.rawValue] = startDate
        result[CodingKeys.endDate.rawValue] = endDate
        result[CodingKeys.description.rawValue] = description
        result[CodingKeys.photo.rawValue] = photo.jpegData(compressionQuality: AppConstants.imageCompressionCoefficient)
        result[CodingKeys.gift.rawValue] = gift.toJSON()
        return result
    }
    
    static func fromJSON(_ dictionary: [AnyHashable: Any]) -> CreateEventRequest? {
        return nil
    }
    
    func toMultipartData() -> [Moya.MultipartFormData]? {
        
        var multipartData = [Moya.MultipartFormData]()
        let keys = CodingKeys.allCases
        
        for key in keys {
            
            switch key {

            case .title:
                guard let data = title.data(using: .utf8) else {
                    preconditionFailure("Unable to get data")
                }
                let name: String = "\(ExternalCodingKeys.event.rawValue)[\(key.rawValue)]"
                let formData: Moya.MultipartFormData = MultipartFormData(provider: .data(data), name: name)
                multipartData.append(formData)
                
            case .startDate:
                guard let data = startDate.iso8601.data(using: .utf8) else {
                    preconditionFailure("Unable to get data")
                }
                let name: String = "\(ExternalCodingKeys.event.rawValue)[\(key.rawValue)]"
                let formData: Moya.MultipartFormData = MultipartFormData(provider: .data(data), name: name)
                multipartData.append(formData)
                
            case .endDate:
                guard let data = endDate.iso8601.data(using: .utf8) else {
                    preconditionFailure("Unable to get data")
                }
                let name: String = "\(ExternalCodingKeys.event.rawValue)[\(key.rawValue)]"
                let formData: Moya.MultipartFormData = MultipartFormData(provider: .data(data), name: name)
                multipartData.append(formData)
                
            case .description:
                guard let data = description.data(using: .utf8) else {
                    preconditionFailure("Unable to get data")
                }
                let name: String = "\(ExternalCodingKeys.event.rawValue)[\(key.rawValue)]"
                let formData: Moya.MultipartFormData = MultipartFormData(provider: .data(data), name: name)
                multipartData.append(formData)
                
            case .photo:
                guard let imageData = photo.downScaleTo10Megabytes() else {
                    preconditionFailure("Unable to get data")
                }
                let name: String = "\(ExternalCodingKeys.event.rawValue)[\(key.rawValue)]"
                let formData: Moya.MultipartFormData = MultipartFormData(provider: .data(imageData),
                                                                         name: name,
                                                                         fileName: "event_image",
                                                                         mimeType: "image/jpg")
                multipartData.append(formData)
                
            case .gift:
                
                var giftFormData = [Moya.MultipartFormData]()
                
                let giftKeys = GiftAttributesJSON.CodingKeys.allCases
                for giftKey in giftKeys {
                    switch giftKey {
    
                    case .name:
                        guard let data = gift.name.data(using: .utf8) else {
                            preconditionFailure("Unable to get data")
                        }
                        let name: String = "\(ExternalCodingKeys.event.rawValue)[\(CodingKeys.gift.rawValue)][][\(giftKey.rawValue)]"
                        giftFormData.append(MultipartFormData(provider: .data(data), name: name))
                        
                    case .link:
                        guard let data = gift.link.data(using: .utf8) else {
                            preconditionFailure("Unable to get data")
                        }
                        let name: String = "\(ExternalCodingKeys.event.rawValue)[\(CodingKeys.gift.rawValue)][][\(giftKey.rawValue)]"
                        giftFormData.append(MultipartFormData(provider: .data(data), name: name))
                        
                    case .price:
                        guard let data = String(gift.price).data(using: .utf8) else {
                            preconditionFailure("Unable to get data")
                        }
                        let name: String = "\(ExternalCodingKeys.event.rawValue)[\(CodingKeys.gift.rawValue)][][\(giftKey.rawValue)]"
                        giftFormData.append(MultipartFormData(provider: .data(data), name: name))
                        
                    case .photo:
                        guard let imageData = gift.photo.downScaleTo10Megabytes() else {
                            preconditionFailure("Unable to get data")
                        }
                        let name: String = "\(ExternalCodingKeys.event.rawValue)[\(CodingKeys.gift.rawValue)][][\(giftKey.rawValue)]"
                        let formData: Moya.MultipartFormData = MultipartFormData(provider: .data(imageData),
                                                                                 name: name,
                                                                                 fileName: "gift_image",
                                                                                 mimeType: "image/jpg")
                        giftFormData.append(formData)
                        
                    case .sizes:
                        guard let sizesData = gift.sizes.toJSONString()?.data(using: .utf8) else {
                            preconditionFailure("Unable to get data")
                        }
                        let sizesName: String = "\(ExternalCodingKeys.event.rawValue)[\(CodingKeys.gift.rawValue)][][\(giftKey.rawValue)]"
        
                        giftFormData.append(MultipartFormData(provider: .data(sizesData), name: sizesName))
                    }
                }
                multipartData.append(contentsOf: giftFormData)
            }
            
        }
        return multipartData
    }
    
}

//{
//  "event": {
//    "title": "title",
//    "start_date": "2019-12-23T20:56:55+02:00",
//    "end_date": "2019-12-23T21:25:00+02:00",
//    "description": "description",
//    "photo": "[file]",
//    "gifts_attributes": [
//      {
//        "name": "Macbook",
//        "link": "https://google.com",
//        "price": 299.99,
//        "size": {
//          "shoe": "european 34",
//          "dress": "xs",
//          "pant": "5",
//          "top": "5"
//        },
//        "photo": "[file]"
//      }
//    ]
//  }
//}
