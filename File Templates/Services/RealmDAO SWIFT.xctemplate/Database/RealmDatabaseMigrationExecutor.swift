//___FILEHEADER___

import Foundation
import RealmSwift

final class RealmDatabaseMigrationExecutor: NSObject {
    
    private let firstReleaseSchemaVersion: UInt64 = 1
    private let secondReleaseSchemaVersion: UInt64 = 2
    
    private var currentSchemaVersion: UInt64 {
        
        guard let fileURL = Realm.Configuration.defaultConfiguration.fileURL else {
            return UInt64(0)
        }
        do {
            let lastSchemaVersion = try schemaVersionAtURL(fileURL)
            return lastSchemaVersion
        } catch {
            // Realm file doesn't exist - realm initial setup
            return UInt64(0)
        }
    }
    
    deinit {
        
    }
    
    override init() {
        super.init()
    }
    
    func performMigrationIfNeeded() {
        
        let config = Realm.Configuration(schemaVersion: secondReleaseSchemaVersion, migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < self.secondReleaseSchemaVersion && self.currentSchemaVersion != 0 {
                
                self.migrateToSecondSchemaVersion(migration: migration, oldSchema: oldSchemaVersion)
                
            }
        })
        Realm.Configuration.defaultConfiguration = config
    }
    
    private func migrateToSecondSchemaVersion(migration: RealmSwift.Migration, oldSchema: UInt64) {
        
        // NOTE: - An example of manual migration
        // See more - https://docs.mongodb.com/realm/sdk/ios/fundamentals/schema-versions-and-migrations/
        // https://docs.mongodb.com/realm/sdk/ios/examples/modify-an-object-schema/
//        migration.enumerateObjects(ofType: MyUser.className()) { _, newObject in
//
//            newObject?["bio"] = ""
//            newObject?["coverImageURL"] = ""
//            newObject?["coverImageThumbURL"] = ""
//            newObject?["eventsCount"] = 0
//            newObject?["friendsCount"] = 0
//        }
        
    }
    
}
