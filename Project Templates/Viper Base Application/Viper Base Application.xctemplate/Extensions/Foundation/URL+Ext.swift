//___FILEHEADER___

import Foundation

extension URL {
    
    func parameters() -> [String: Any] {
        
        var dict: [String: Any] = [:]
        guard let queryItems = URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems else {
            return dict
        }
        for item in queryItems {
            dict[item.name] = item.value ?? ""
        }
        return dict
    }
    
}
