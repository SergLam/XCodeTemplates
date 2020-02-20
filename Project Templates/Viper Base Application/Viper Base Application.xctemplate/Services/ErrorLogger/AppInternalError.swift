//___FILEHEADER___

import Foundation

enum AppInternalError: Error, LocalizedError {
    
    case fontNotFound(fontName: String)
    case error(errorMessage: String)
    
    var description: String {
        switch self {
        case .fontNotFound(let fontName):
            return "Invalid font name \(fontName) / font file is missing / not registered in plist"
        case .error(let errorMessage):
            return errorMessage
        }
    }
    
    var errorDescription: String? {
        return self.description
    }
    
    var nsError: NSError {
        switch self {
            
        case .fontNotFound:
            let userInfo: [String: Any] = [NSLocalizedDescriptionKey: self.description,
                                           NSLocalizedFailureReasonErrorKey: self.description]
            return NSError(domain: Environment.bundleId, code: -1001, userInfo: userInfo)
            
        case .error(let errorMessage):
            
            let userInfo: [String: Any] = [NSLocalizedDescriptionKey: errorMessage,
                                           NSLocalizedFailureReasonErrorKey: errorMessage]
            return NSError(domain: Environment.bundleId, code: -1001, userInfo: userInfo)
        }
    }
    
}
