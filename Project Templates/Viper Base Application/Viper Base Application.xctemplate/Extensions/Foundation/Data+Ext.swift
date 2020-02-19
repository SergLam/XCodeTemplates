//___FILEHEADER___

import Foundation

extension Data {
    
    func hexString() -> String {
        return self.map{ String(format: "%02.2hhx", $0) }.joined()
    }
    
}
