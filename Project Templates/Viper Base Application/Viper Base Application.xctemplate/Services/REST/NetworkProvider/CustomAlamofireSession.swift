//___FILEHEADER___

import Alamofire
import Foundation

final class CustomAlamofireSession: Alamofire.Session {
    
    private static let requestTimeOutTimeInterval: TimeInterval = {
        #if DEBUG
        return 60.0
        #else
        return 60.0
        #endif
    }()
    
    final class func defaultAlamofireSession() -> Session {
        
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = requestTimeOutTimeInterval
        configuration.timeoutIntervalForResource = requestTimeOutTimeInterval
        return Session(configuration: configuration, startRequestsImmediately: false)
    }
    
}
