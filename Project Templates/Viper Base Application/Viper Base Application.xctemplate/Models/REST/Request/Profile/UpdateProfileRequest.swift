//
//  UpdateProfileRequest.swift
//  GiftWishesiOS
//
//  Created by Andrii Mazepa on 18.12.2019.
//  Copyright © 2019 Serg Liamtsev. All rights reserved.
//

import Foundation
import Moya

struct UpdateProfileRequest: Decodable {
    
    var userId: Int
    
    var firstName: String
    var lastName: String
    var userName: String
    var phoneNumber: String
    
    var shippingAddress: String?
    
    enum ExternalCodingKeys: String, CodingKey {
        case profile = "profile"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case username = "username"
        case phoneNumber = "phone_number"
        case shippingAddress = "shipping_address"
    }
    
    init(id: Int, firstName: String, lastName: String, userName: String, phoneNumber: String, shippingAddress: String? = nil) {
        self.userId = id
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.phoneNumber = phoneNumber
        self.shippingAddress = shippingAddress
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ExternalCodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .profile)
        userId = try nestedContainer.decodeForce(Int.self, forKey: .id)
        firstName = try nestedContainer.decode(String.self, forKey: .firstName)
        lastName = try nestedContainer.decode(String.self, forKey: .lastName)
        userName = try nestedContainer.decode(String.self, forKey: .username)
        phoneNumber = try nestedContainer.decode(String.self, forKey: .phoneNumber)
        shippingAddress = try nestedContainer.decodeIfPresent(String.self, forKey: .shippingAddress)
    }
    
}

// MARK: - Encodable
extension UpdateProfileRequest: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ExternalCodingKeys.self)
        var nestedContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .profile)
        try nestedContainer.encodeIfPresent(userId, forKey: .id)
        try nestedContainer.encodeIfPresent(firstName, forKey: .firstName)
        try nestedContainer.encodeIfPresent(lastName, forKey: .lastName)
        try nestedContainer.encodeIfPresent(userName, forKey: .username)
        try nestedContainer.encodeIfPresent(phoneNumber, forKey: .phoneNumber)
        try nestedContainer.encodeIfPresent(shippingAddress, forKey: .shippingAddress)
    }
    
}

// MARK: - JSONAble
extension UpdateProfileRequest: JSONAble {
    
    typealias ReturnType = UpdateProfileRequest
    
    func toJSON() -> [String: Any] {
        
        var result: [String: Any] = [:]
        result[CodingKeys.id.rawValue] = userId
        result[CodingKeys.firstName.rawValue] = firstName
        result[CodingKeys.lastName.rawValue] = lastName
        result[CodingKeys.username.rawValue] = userName
        result[CodingKeys.phoneNumber.rawValue] = phoneNumber
        result[CodingKeys.shippingAddress.rawValue] = shippingAddress
        
        let externalContainer: [String: Any] = [ExternalCodingKeys.profile.rawValue: result]
        return externalContainer
    }
    
    static func fromJSON(_ dictionary: [AnyHashable: Any]) -> UpdateProfileRequest? {
        return nil
    }
    
    func toMultipartData() -> [Moya.MultipartFormData]? {
        return nil
    }
    
}

//{
//  "profile": {
//    "first_name": "NotJohn2",
//    "last_name": "Snow2",
//    "username": "JohnSno2w",
//    "shipping_address": "Lviv. 205, Gorodotska Str. 79015"
//  }
//}
