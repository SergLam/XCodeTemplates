//___FILEHEADER___

import Foundation

enum DatabaseError: Error, LocalizedError {
    
    case databaseAlreadyInWriteTransaction
    
    var description: String {
        switch self {
        case .databaseAlreadyInWriteTransaction:
            return "Database already in a write transaction."
        }
    }
    
     var errorDescription: String? {
        return self.description
    }
    
}
