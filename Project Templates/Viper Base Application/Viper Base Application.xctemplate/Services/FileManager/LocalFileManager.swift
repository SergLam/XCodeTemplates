//___FILEHEADER___

import UIKit

final class LocalFileManager {
    
    static let shared = LocalFileManager()
    
    private static let appCacheDirectoryName = Bundle.main.bundleIdentifier ?? "\(___PROJECTNAME___)"
    
    private let manager = FileManager.default
    
    private var cacheDirectoryURL: URL? {
        
        guard let cacheDirectory = manager.urls(for: .cachesDirectory,
                                                in: .userDomainMask).first else {
                                                    let message = "Unable to get cache directory"
                                                    ErrorLoggerService.logWithTrace(message)
                                                    return nil
        }
        let folderURL = cacheDirectory.appendingPathComponent(LocalFileManager.appCacheDirectoryName)
        return manager.fileExists(atPath: folderURL.path) ? folderURL : nil
    }
    
    private init() {
        
    }
    
    func saveFileToCache(imageName: String, data: Data, fileType: CacheFileType) -> String? {
        
        guard let cacheDirectory = createSubFolderInCacheDirectory(folderName: LocalFileManager.appCacheDirectoryName) else {
            let message = "Unable to get cache directory"
            ErrorLoggerService.logWithTrace(message)
            return nil
        }
        
        let fileURL = cacheDirectory.appendingPathComponent(imageName+".\(fileType.rawValue)")
        
        if manager.fileExists(atPath: fileURL.path) {
            do {
                try manager.removeItem(atPath: fileURL.path)
            } catch {
                let message: String = error.localizedDescription
                ErrorLoggerService.logWithTrace(message)
            }
        }
        
        do {
            try data.write(to: fileURL)
        } catch {
            let message: String = error.localizedDescription
            ErrorLoggerService.logWithTrace(message)
        }
        return fileURL.lastPathComponent
    }
    
    func loadDataFromCache(fileName: String) -> Data? {
        
        guard let cacheDirectory = cacheDirectoryURL else {
            let message = "Unable to get cache directory"
            ErrorLoggerService.logWithTrace(message)
            return nil
        }
        
        let imageUrl = cacheDirectory.appendingPathComponent(fileName)
        do {
            return try Data(contentsOf: imageUrl)
        } catch {
            let message: String = error.localizedDescription
            ErrorLoggerService.logWithTrace(message)
        }
        return nil
    }
    
    func removeFile(filePath: String) {
        
        do {
            try manager.removeItem(atPath: filePath)
        } catch {
            let message: String = error.localizedDescription
            ErrorLoggerService.logWithTrace(message)
        }
    }
    
    func createSubFolderInCacheDirectory(folderName: String) -> URL? {
        
        guard let cacheDirectory = manager.urls(for: .cachesDirectory,
                                                in: .userDomainMask).first else {
                                                    let message = "Unable to get cache directory"
                                                    ErrorLoggerService.logWithTrace(message)
                                                    return nil
        }
        
        let folderURL = cacheDirectory.appendingPathComponent(folderName)
        // If folder URL does not exist, create it
        if !manager.fileExists(atPath: folderURL.path) {
            do {
                // Attempt to create folder
                try manager.createDirectory(atPath: folderURL.path,
                                            withIntermediateDirectories: true,
                                            attributes: nil)
            } catch {
                // Creation failed.
                let message: String = error.localizedDescription
                ErrorLoggerService.logWithTrace(message)
                return nil
            }
        }
        // Folder either exists, or was created. Return URL
        return folderURL
    }
    
}
