//
//  FriendRequestJSON.swift
//  GiftWishesiOS
//
//  Created by Serg Liamthev on 03.01.2020.
//  Copyright © 2020 Serg Liamtsev. All rights reserved.
//

import Foundation

struct FriendRequestJSON: Decodable {
    
    var id: Int
    var user: UserJSON
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeForce(Int.self, forKey: .id)
        user = try container.decode(UserJSON.self, forKey: .user)
    }
    
}

// MARK: - Encodable
extension FriendRequestJSON: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(user, forKey: .user)
    }
    
}
