//
//  InstagramAuthRequest.swift
//  GiftWishesiOS
//
//  Created by Serg Liamthev on 19.12.2019.
//  Copyright © 2019 Serg Liamtsev. All rights reserved.
//

import Foundation
import Moya

struct InstagramAuthRequest: Decodable {
    
    let appId: String = Environment.instagramAppId
    let clientId: String = Environment.instagramAppId
    let clientSecret: String = Environment.instagramClientSecret
    let grantType: String = "authorization_code"
    let redirectURL: String = Environment.instagramRedirectURL.absoluteString
    var code: String
    
    enum CodingKeys: String, CodingKey {
        case appId = "app_id"
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case grantType = "grant_type"
        case redirectURL = "redirect_uri"
        case code = "code"
    }
    
    init(code: String) {
        self.code = code
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
    }
}

// MARK: - Encodable
extension InstagramAuthRequest: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(appId, forKey: .appId)
        try container.encodeIfPresent(clientId, forKey: .clientId)
        try container.encodeIfPresent(clientSecret, forKey: .clientSecret)
        try container.encodeIfPresent(grantType, forKey: .grantType)
        try container.encodeIfPresent(redirectURL, forKey: .redirectURL)
        try container.encodeIfPresent(code, forKey: .code)
    }
    
}

// MARK: - JSONAble
extension InstagramAuthRequest: JSONAble {
    
    typealias ReturnType = InstagramAuthRequest
    
    func toJSON() -> [String: Any] {
        var result: [String: Any] = [:]
        result[CodingKeys.appId.rawValue] = appId
        result[CodingKeys.clientId.rawValue] = clientId
        result[CodingKeys.clientSecret.rawValue] = clientSecret
        result[CodingKeys.grantType.rawValue] = grantType
        result[CodingKeys.redirectURL.rawValue] = redirectURL
        result[CodingKeys.code.rawValue] = code
        return result
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
    
    static func fromJSON(_ dictionary: [AnyHashable: Any]) -> InstagramAuthRequest? {
        return nil
    }
    
}
