//
//  GiftAttributesJSON.swift
//  GiftWishesiOS
//
//  Created by Serg Liamthev on 22.12.2019.
//  Copyright © 2019 Serg Liamtsev. All rights reserved.
//

import Moya
import UIKit

struct GiftAttributesJSON: Decodable {
    
    var name: String
    var link: String
    var price: Double
    var photo: UIImage
    var sizes: GiftSizesJSON
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name = "name"
        case link = "link"
        case price = "price"
        case photo = "photo"
        case sizes = "size"
    }
    
    init(name: String, link: String, price: Double, photo: UIImage, sizes: GiftSizesJSON) {
        self.name = name
        self.link = link
        self.price = price
        self.photo = photo
        self.sizes = sizes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        link = try container.decode(String.self, forKey: .link)
        price = try container.decodeForce(Double.self, forKey: .price)
        
        let imageBase64Str = try container.decode(String.self, forKey: .photo)
        photo = imageBase64Str.convertBase64ToImage() ?? UIImage()
        sizes = try container.decode(GiftSizesJSON.self, forKey: .sizes)
    }
    
}

// MARK: - Encodable
extension GiftAttributesJSON: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(link, forKey: .link)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(photo.base64String(), forKey: .photo)
        try container.encodeIfPresent(sizes, forKey: .sizes)
    }
    
}

// MARK: - JSONAble
extension GiftAttributesJSON: JSONAble {
    
    typealias ReturnType = GiftAttributesJSON
    
    func toJSON() -> [String: Any] {
        var result: [String: Any] = [:]
        result[CodingKeys.name.rawValue] = name
        result[CodingKeys.link.rawValue] = link
        result[CodingKeys.price.rawValue] = price
        result[CodingKeys.photo.rawValue] = photo.jpegData(compressionQuality: AppConstants.imageCompressionCoefficient)
        result[CodingKeys.sizes.rawValue] = sizes
        return result
    }
    
    static func fromJSON(_ dictionary: [AnyHashable: Any]) -> GiftAttributesJSON? {
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

//"gifts_attributes": [
//  {
//    "name": "Macbook",
//    "link": "https://google.com",
//    "price": 299.99,
//    "size": {
//      "shoe": "european 34",
//      "dress": "xs",
//      "pant": "5",
//      "top": "5"
//    },
//    "photo": "[file]"
//  }
//]
