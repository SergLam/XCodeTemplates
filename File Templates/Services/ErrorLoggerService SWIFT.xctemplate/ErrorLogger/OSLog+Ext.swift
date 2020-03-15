//___FILEHEADER___

import os
import Foundation

// https://www.lordcodes.com/articles/clear-and-searchable-logging-in-swift-with-oslog
extension OSLog {
    
    private static var subsystem = Bundle.main.bundleIdentifier ?? ""

    static let error = OSLog(subsystem: subsystem, category: "Internal_Error")    
}
