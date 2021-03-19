//
//  SessionModelProtocol.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import JWTDecode

protocol SessionModelProviderProtocol {
    
    func load() -> SessionModelProtocol?
    
    func save(model: SessionModelProtocol)
    
    func erase()
}

public protocol SessionModelProtocol: Codable {
    
    var accessToken: String? { get set }
    
    var userId: Int? { get set }
    func getMyUserId() -> Int?
    
    var refreshToken: String? { get set }
    
    var accessTokenExpirationDate: Date? { get set }
}

extension SessionModelProtocol {
    
    public func getMyUserId() -> Int? {
        
        guard let accessToken = self.accessToken else {
            // NOTE: - causes crash at debug session if user is not authorized
            // assertionFailure("Access token is nil")
            return nil
        }
        guard let jwt = try? decode(jwt: accessToken) else {
            assertionFailure("JWT Parsing failed")
            return nil
        }
        guard let userIdStr = jwt.body["ProfileId"] as? String else {
            assertionFailure("User Id is missing in JWT data")
            return nil
        }
        guard let userIdInt = Int(userIdStr) else {
            assertionFailure("Unable to cast userId from String")
            return nil
        }
        return userIdInt
    }
    
}
