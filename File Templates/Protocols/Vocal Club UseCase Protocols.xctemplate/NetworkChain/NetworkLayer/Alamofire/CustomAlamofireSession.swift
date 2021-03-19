//
//  CustomAlamofireSession.swift
//  VocalClub
//
//  Created by Serg Liamthev on 25.01.2021.
//  Copyright © 2021 VocalClub. All rights reserved.
//

import Alamofire
import Foundation

final class CustomAlamofireSession: Alamofire.Session {
    
    // MARK: - Private properties
    private class var isNetworkLoggingEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    private static let requestTimeOutTimeInterval: TimeInterval = {
        return AppConstants.requestTimeOutTimeInterval
    }()
    
    final class func sessionInstance(isAllowedMobileAccess: Bool) -> Session {
        
        let configuration = URLSessionConfiguration.default
        configuration.isDiscretionary = false
        configuration.waitsForConnectivity = true
        configuration.sessionSendsLaunchEvents = true
        configuration.headers = .default
        
        configuration.allowsExpensiveNetworkAccess = isAllowedMobileAccess
        configuration.allowsConstrainedNetworkAccess = isAllowedMobileAccess
        
        configuration.timeoutIntervalForRequest = requestTimeOutTimeInterval
        configuration.timeoutIntervalForResource = requestTimeOutTimeInterval
        configuration.sharedContainerIdentifier = "group.vocal_club.apps"
        
        let eventMonitors: [Alamofire.EventMonitor] = isNetworkLoggingEnabled ? [AlamofireLogger()] : []
        
        return Session(configuration: configuration, startRequestsImmediately: true, eventMonitors: eventMonitors)
    }
    
}
