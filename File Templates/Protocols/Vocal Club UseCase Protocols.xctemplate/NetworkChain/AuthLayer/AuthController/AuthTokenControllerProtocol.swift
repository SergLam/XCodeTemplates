//
//  AuthTokenControllerProtocol.swift
//  VocalClub
//
//  Created by NLT on 12/1/20.
//  Copyright © 2020 VocalClub. All rights reserved.
//

import Foundation

protocol AuthTokenControllerProtocol {

    var networkLayer: NetworkLayerProtocol { get set }
    var session: SessionModelProtocol { get set }
    
    var delegate: AuthTokenControllerDelegate? { get set }

    init(networkLayer: NetworkLayerProtocol,
         session: SessionModelProtocol,
         sessionProvider: SessionModelProviderProtocol)

    func isAccessTokenValid() -> Bool

    func getAccessToken(force: Bool) -> String?
    
    func updateAccessToken(forceUpdate: Bool,
                           onSuccess: @escaping (String) -> Void,
                           onFailure: @escaping (APIError) -> Void)
    
    func updateSession(accessToken: String?, refreshToken: String?)
    
    func clearSession()
    func clearSessionPartially()

}

protocol AuthTokenControllerDelegate: class {
    
    func authenticatedSuccessfully()
    func authenticationFailed(error: APIError)
    
}
