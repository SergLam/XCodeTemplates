//___FILEHEADER___

import Foundation
import Realm
import RealmSwift

extension Migration {
    
    func hadProperty(onType typeName: String, property propertyName: String) -> Bool {
        var hasPropery = false
        self.enumerateObjects(ofType: typeName) { oldObject, _ in
            hasPropery = oldObject?.objectSchema.properties.contains(where: { $0.name == propertyName }) ?? false
            return
        }
        return hasPropery
    }

    func renamePropertyIfExists(onType typeName: String, from oldName: String, to newName: String) {
        if hadProperty(onType: typeName, property: oldName) {
            renameProperty(onType: typeName, from: oldName, to: newName)
        }
    }
    
}
