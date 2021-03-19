//
//  AuthToketnController.swift
//  VocalClub
//
//  Created by NLT on 12/1/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation
import JWTDecode
import UIKit

final class AuthTokenController: AuthTokenControllerProtocol {
    
    var networkLayer: NetworkLayerProtocol
    
    weak var delegate: AuthTokenControllerDelegate?
    
    var session: SessionModelProtocol
    
    let sessionProvider: SessionModelProviderProtocol
    
    let firstRun: Bool
    
    var lastRefreshTokenToUse: String = ""
    
    required init(networkLayer: NetworkLayerProtocol,
         session: SessionModelProtocol,
         sessionProvider: SessionModelProviderProtocol) {
        self.networkLayer = networkLayer
        self.sessionProvider = sessionProvider
        self.session = session
        firstRun = true
    }
    
    func isAccessTokenValid() -> Bool {
        let isValid: Bool
        if let accessToken = session.accessToken, let expirationDate = session.accessTokenExpirationDate {
            if checkTokenExpired(accessToken: accessToken, expirationDate: expirationDate) {
                isValid = false
            } else {
                isValid = true
            }
        } else {
            isValid = false
        }
        return isValid
    }
    
    func getAccessToken(force: Bool = false) -> String? {
        if let accessToken = session.accessToken, let expirationDate = session.accessTokenExpirationDate {
            if checkTokenExpired(accessToken: accessToken, expirationDate: expirationDate) || force {
                updateAccessToken(forceUpdate: force, onSuccess: { _ in
                    // Nothing to do here
                }) { error in
                    // TODO: change to main
                    self.delegate?.authenticationFailed(error: error)
                }
            }
            return accessToken
        } else {
            if force {
                updateAccessToken(forceUpdate: force, onSuccess: { _ in
                    
                }) { error in
                    // TODO: change to main
                    self.delegate?.authenticationFailed(error: error)
                }
            }
        }
        self.delegate?.authenticationFailed(error: APIError.accessTokenInvalid)
        return nil
    }
    
    func updateAccessToken(forceUpdate: Bool,
                           onSuccess: @escaping (String) -> Void,
                           onFailure: @escaping (APIError) -> Void) {
        if !forceUpdate {
            if isAccessTokenValid() {
                if let accessToken = session.accessToken {
                    onSuccess(accessToken)
                    return
                }
            }
        }
        
        guard !Thread.isMainThread else {
            updateAccessTokenOnMain(forceUpdate: forceUpdate,
                                    onSuccess: onSuccess,
                                    onFailure: onFailure)
            return
        }
        
        DispatchQueue.main.async {
            self.updateAccessTokenOnMain(forceUpdate: forceUpdate,
                                         onSuccess: onSuccess,
                                         onFailure: onFailure)
        }
    }
    
    private func updateAccessTokenOnMain(forceUpdate: Bool,
                                         onSuccess: @escaping (String) -> Void,
                                         onFailure: @escaping (APIError) -> Void) {
        let state = UIApplication.shared.connectedScenes.first?.activationState
        if state != .foregroundActive {
            return
        }
        
        if session.refreshToken != nil {
            
        } else {
            session = sessionProvider.load() ?? SessionModel(model: session)
        }
        
        guard let refreshToken = session.refreshToken, let accessToken = session.accessToken else {
            onFailure(APIError.accessTokenUpdateFail)
            sessionProvider.erase()
            return
        }
        
        updateAccessToken(refreshToken, accessToken: accessToken, onSuccess: { session in
            self.updateSession(accessToken: session.accessToken, refreshToken: session.refreshToken)
        }) { error in
            if let error = error as? APIError {
                switch error {
                case .accessTokenUpdateFail:
                    onFailure(APIError.accessTokenUpdateFail)
                    self.sessionProvider.erase()
                default:
                    onFailure(APIError.accessTokenInvalid)
                }
            } else {
                onFailure(APIError.accessTokenUpdateFail)
            }
        }
    }
    
    func checkTokenExpired(accessToken: String, expirationDate: Date) -> Bool {
        if expirationDate > Date() {
            return false
        } else {
            return true
        }
    }
    
    func updateAccessToken(_ refreshToken: String,
                           accessToken: String,
                           onSuccess: @escaping (SessionModelProtocol) -> Void,
                           onFailure: @escaping (Error) -> Void) {
        if refreshToken == lastRefreshTokenToUse {
            return
        } else {
            lastRefreshTokenToUse = refreshToken
        }
        
        let useCase = RefreshTokenUseCase(refreshToken: refreshToken, accessToken: accessToken, onSuccess: { successModel in
            let session = SessionModel()
            session.accessToken = successModel.accessToken
            session.refreshToken = successModel.refreshToken
            let model = SessionModel(model: session)
            onSuccess(model)
        }) { error in
            onFailure(error)
        }
        APIClient.shared.performUseCase(useCase: useCase)
    }
    
    func updateSession(accessToken: String?, refreshToken: String?) {
        session.accessToken = accessToken
        var myDate: Date?
        do {
            if let unwrapedNewValue = accessToken {
                let jwt = try decode(jwt: unwrapedNewValue)
                if let interval = jwt.expiresAt?.timeIntervalSince1970 {
                    myDate = Date(timeIntervalSince1970: interval)
                }
            }
        } catch let error {
            print(error)
        }
        session.accessTokenExpirationDate = myDate
        if let refreshToken = refreshToken {
            session.refreshToken = refreshToken
        }
        sessionProvider.save(model: session)
        delegate?.authenticatedSuccessfully()
    }
    
    func clearSession() {
        sessionProvider.erase()
        session = SessionModel()
    }
    
    func clearSessionPartially() {
        sessionProvider.erase()
        session.refreshToken = nil
    }
    
    func updateTokenState() {
        if isAccessTokenValid() {
            delegate?.authenticatedSuccessfully()
        } else {
            delegate?.authenticationFailed(error: APIError.accessTokenInvalid)
        }
    }
    
}
