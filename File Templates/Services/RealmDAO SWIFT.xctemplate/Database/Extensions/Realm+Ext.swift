//___FILEHEADER___

import Foundation
import Realm
import RealmSwift

extension Realm {
    
    /**
     // https://github.com/realm/realm-cocoa/issues/4511
      Terminating app due to uncaught exception 'RLMException', reason: 'The Realm is already in a write transaction'
     */
    func safeWrite(_ block: (() throws -> Void)) throws {
           if isInWriteTransaction {
               try block()
           } else {
               try write(block)
           }
    }
    
}
