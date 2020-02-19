//___FILEHEADER___

import Foundation

extension String {
    
    func getFileTypeFromURL() -> CacheFileType {
        
        guard let fileExtension = self.split(separator: ".").last else {
            return .none
        }
        guard let fileType: CacheFileType = CacheFileType(rawValue: String(fileExtension)) else {
            return .none
        }
        return fileType
    }
    
}
