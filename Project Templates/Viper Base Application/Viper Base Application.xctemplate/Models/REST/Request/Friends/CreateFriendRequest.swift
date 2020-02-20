//
//  CreateFriendRequest.swift
//  GiftWishesiOS
//
//  Created by Serg Liamthev on 04.01.2020.
//  Copyright © 2020 Serg Liamtsev. All rights reserved.
//

import Foundation
import Moya

struct CreateFriendRequest: Decodable {
    
    var userId: Int = 0
    
    enum ExternalCodingKeys: String, CodingKey {
        case friendRequest = "friend_request"
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "friend_id"
    }
    
    init(userId: Int) {
        self.userId = userId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ExternalCodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .friendRequest)
        userId = try nestedContainer.decodeForce(Int.self, forKey: .userId)
    }
    
}

// MARK: - Encodable
extension CreateFriendRequest: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ExternalCodingKeys.self)
        var nestedContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .friendRequest)
        try nestedContainer.encode(userId, forKey: .userId)
    }
    
}

// MARK: - JSONAble
extension CreateFriendRequest: JSONAble {
    
    typealias ReturnType = AcceptFriendRequest
    
    func toJSON() -> [String: Any] {
        var result: [String: Any] = [:]
        let nestedDictionary: [String: Any] = [CodingKeys.userId.rawValue: userId]
        result[ExternalCodingKeys.friendRequest.rawValue] = nestedDictionary
        return result
    }
    
    static func fromJSON(_ dictionary: [AnyHashable: Any]) -> AcceptFriendRequest? {
        return nil
    }
    
    func toMultipartData() -> [Moya.MultipartFormData]? {
        return nil
    }
    
}

//{
//  "friend_request": {
//    "friend_id": 5
//  }
//}
