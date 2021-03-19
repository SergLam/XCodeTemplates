//
//  SessionModel.swift
//  VocalClub
//
//  Created by NLT on 10/21/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import JWTDecode

public final class SessionModelProvider: SessionModelProviderProtocol {
    
    private let storage: StorageProtocol
    private let keyChainStorage: StorageProtocol
    
    private let plistDecoder: PropertyListDecoder = PropertyListDecoder()
    private let plistEncoder: PropertyListEncoder = PropertyListEncoder()
    
    public init(storage: StorageProtocol,
                keyChainStorage: StorageProtocol) {
        self.storage = storage
        self.keyChainStorage = keyChainStorage
    }
    
    public func load() -> SessionModelProtocol? {
        if let sessionModel = loadFromUserDefaults() {
            return sessionModel
        }
        return nil
    }
    
    private func loadFromUserDefaults() -> SessionModelProtocol? {
        do {
            
            let key: String = LocalStorageKeys.sessionModelKey.rawValue
            if let data = storage.load(key: key) {
                return try plistDecoder.decode(SessionModel.self, from: data)
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    private func loadFromKeyChain() -> SessionModelProtocol? {
        do {
            let key: String = LocalStorageKeys.sessionModelKey.rawValue
            if let data = keyChainStorage.load(key: key) {
                return try plistDecoder.decode(SessionModel.self, from: data)
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    public func save(model: SessionModelProtocol) {
        saveUserDefaults(model: model)
    }
    
    private func saveUserDefaults(model: SessionModelProtocol) {
        do {
            let key: String = LocalStorageKeys.sessionModelKey.rawValue
            let data = try plistEncoder.encode(SessionModel(model: model))
            _ = storage.save(key: key, data: data)
        } catch { }
    }
    
    private func saveKeyChain(model: SessionModelProtocol) {
        do {
            let key: String = LocalStorageKeys.sessionModelKey.rawValue
            let data = try plistEncoder.encode(SessionModel(model: model))
            _ = keyChainStorage.save(key: key, data: data)
        } catch { }
    }
    
    public func erase() {
        
        let key: String = LocalStorageKeys.sessionModelKey.rawValue
        _ = storage.remove(key: key)
        _ = keyChainStorage.remove(key: key)
    }
}

final class SessionModel: SessionModelProtocol {
    
    required init() {}
    
    convenience init(model: SessionModelProtocol) {
        self.init()
        self.accessToken = model.accessToken
        self.refreshToken = model.refreshToken
        self.userId = model.getMyUserId()
        self.accessTokenExpirationDate = model.accessTokenExpirationDate
    }
    
    var accessToken: String?
    
    var refreshToken: String?
    
    var userId: Int?
    
    var accessTokenExpirationDate: Date?
    
}
