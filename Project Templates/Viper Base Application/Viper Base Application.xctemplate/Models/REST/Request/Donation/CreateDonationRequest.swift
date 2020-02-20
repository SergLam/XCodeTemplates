//
//  CreateDonationRequest.swift
//  GiftWishesiOS
//
//  Created by Serg Liamthev on 30.12.2019.
//  Copyright © 2019 Serg Liamtsev. All rights reserved.
//

import Foundation
import Moya

struct CreateDonationRequest: Decodable {
    
    var giftId: Int
    var eventId: Int
    var recipientId: Int
    var amount: Double
    var message: String
    
    // NOTE: Transaction key, returned for Braintree SDK
    var nonce: String
    
    enum ExternalCodingKeys: String, CodingKey {
        case donation = "donation"
    }
    
    enum CodingKeys: String, CodingKey {
        case giftId = "gift_id"
        case eventId = "event_id"
        case recipientId = "recipient_id"
        case amount = "amount"
        case message = "message"
        case nonce = "nonce"
    }
    
    init(giftId: Int, eventId: Int, recipientId: Int, amount: Double, message: String, nonce: String) {
        self.giftId = giftId
        self.eventId = eventId
        self.recipientId = recipientId
        self.amount = amount
        self.message = message
        self.nonce = nonce
    }
    
    init(from decoder: Decoder) throws {
        
        let externalContainer = try decoder.container(keyedBy: ExternalCodingKeys.self)
        let container = try externalContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .donation)
        giftId = try container.decodeForce(Int.self, forKey: .giftId)
        eventId = try container.decodeForce(Int.self, forKey: .eventId)
        recipientId = try container.decodeForce(Int.self, forKey: .recipientId)
        amount = try container.decodeForce(Double.self, forKey: .amount)
        message = try container.decode(String.self, forKey: .message)
        nonce = try container.decode(String.self, forKey: .nonce)
    }
    
}

// MARK: - Encodable
extension CreateDonationRequest: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var externalContainer = encoder.container(keyedBy: ExternalCodingKeys.self)
        var container = externalContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .donation)
        try container.encodeIfPresent(giftId, forKey: .giftId)
        try container.encodeIfPresent(eventId, forKey: .eventId)
        try container.encodeIfPresent(recipientId, forKey: .recipientId)
        try container.encodeIfPresent(amount, forKey: .amount)
        try container.encodeIfPresent(message, forKey: .message)
        try container.encodeIfPresent(nonce, forKey: .nonce)
    }
    
}

// MARK: - JSONAble
extension CreateDonationRequest: JSONAble {
    
    typealias ReturnType = CreateDonationRequest
    
    func toJSON() -> [String: Any] {
        
        var body: [String: Any] = [:]
        body[CodingKeys.giftId.rawValue] = giftId
        body[CodingKeys.eventId.rawValue] = eventId
        body[CodingKeys.recipientId.rawValue] = recipientId
        body[CodingKeys.amount.rawValue] = amount
        body[CodingKeys.message.rawValue] = message
        body[CodingKeys.nonce.rawValue] = nonce
        
        var result: [String: Any] = [:]
        result[ExternalCodingKeys.donation.rawValue] = body
        return result
    }
    
    static func fromJSON(_ dictionary: [AnyHashable: Any]) -> CreateDonationRequest? {
        return nil
    }
    
    func toMultipartData() -> [Moya.MultipartFormData]? {
        return nil
    }
    
}

//{
//  "donation": {
//    "gift_id": 1,
//    "event_id": 52,
//    "recipient_id": 5,
//    "amount": 51.99,
//    "message": "special for you",
//    "nonce": "<TRANSACTION_KEY_FROM_BRAINTREE>"
//  }
//}
