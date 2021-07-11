//___FILEHEADER___

import Foundation
import RealmSwift

// NOTE: - ___VARIABLE_optionName___.configureMigration() - call this method before first call to the database in your app.
// E.g. at the app delegate / scene delegate init method
final class ___VARIABLE_optionName___ {
    
    static let shared = ___VARIABLE_optionName___()
    
    // NOTE: - An example of query repo / command repos. Should be stored here - due to singleton limitations.
//    lazy var myUserQueryRepo: MyUserDatabaseQueryRepo = MyUserDatabaseQueryRepo(config: ___VARIABLE_optionName___.shared.configuration, queue: ___VARIABLE_optionName___.databaseOperationsQueue)
//    lazy var myUserCommandRepo: MyUserDatabaseCommandRepo = MyUserDatabaseCommandRepo(config: ___VARIABLE_optionName___.shared.configuration, queue: ___VARIABLE_optionName___.databaseOperationsQueue)
//
    
    /**
     Queue to read + write object synchroniously(reader-writer problem)
     Always use it!
     Why concurrent? - Because write / delete operations should goes in `.async(flags: .barrier)` block to make it safe.
     Reading - may stay concurrent.
     */
    private static let databaseOperationsQueue: DispatchQueue = DispatchQueue(label: "\(Environment.bundleId).realm-queue", qos: .userInteractive, attributes: [.concurrent], autoreleaseFrequency: .workItem, target: nil)
    
    lazy var migrationExecutor: RealmDatabaseMigrationExecutor = RealmDatabaseMigrationExecutor()
    
    lazy var realm: Realm = {
        do {
            return try Realm()
        } catch {
            let message: String = "Unable to create realm instance \(error)"
            ErrorLoggerService.logWithTrace(message)
            preconditionFailure(message)
        }
    }()
    
    /**
     Get this configuration each time when you need to perform CRUD operation
     */
    private var configuration: Realm.Configuration {
        return realm.configuration
    }
    
    var databaseFileURL: URL? {
        return realm.configuration.fileURL
    }
    
    private init() {
        
    }
    
    /**
     Domain specific operations should be here
     */
    func performCommand(command: @escaping VoidClosure) {
        
        ___VARIABLE_optionName___.databaseOperationsQueue.async(flags: .barrier) {
            command()
        }
    }
    
    // MARK: - Base CRUD operations implemented with generics
    /**
     Use to write NEW UNMANAGED objects to database
     */
    func writeUnsafe<T: Object>(value: [T],
                                policy: Realm.UpdatePolicy = .all,
                                onCompletion: @escaping VoidClosure) {
        
        ___VARIABLE_optionName___.databaseOperationsQueue.async(flags: .barrier) { [weak self] in
            
            guard let `self` = self else { return }
            
            do {
                let newRealm = try Realm(configuration: self.configuration)
                let value = value.filter{ return $0.isInvalidated == false }
                
                try newRealm.write {
                    newRealm.add(value, update: policy)
                    try newRealm.commitWrite()
                    onCompletion()
                }
            } catch {
                let message: String = "\(error.localizedDescription)"
                ErrorLoggerService.logWithTrace(message)
                onCompletion()
            }
        }
    }
    
    /**
     Use to write in background for already existing objects in database
     */
    func write<T: Object>(value: [T], completion: @escaping VoidClosure) {
        
        let isManaged: Bool = value.first?.realm != nil
        
        for obj in value {
            
            if isManaged {
                
                ___VARIABLE_optionName___.shared.writeAsync(obj: obj, block: { realm, obj in
                    guard let objReference = obj else { return }
                    realm.add(objReference, update: .all)
                    completion()
                })
                
            } else {
                
                RealmDAO.shared.writeUnsafe(value: value, onCompletion: {
                    completion()
                })
                
            }
            
        }
    }
    
    func readAll<T: Object>(object: T.Type,
                            completion: @escaping ResultClosure<[T]>) {
        
        ___VARIABLE_optionName___.databaseOperationsQueue.async { [weak self] in
            
            guard let `self` = self else { return }
            
            do {
                let realm = try Realm(configuration: self.configuration)
                let readResults = realm.objects(T.self)
                completion(.success(Array(readResults)))
                
            } catch {
                let message: String = "Unable to create realm instance \(error.localizedDescription)"
                ErrorLoggerService.logWithTrace(message)
                completion(.failure(error))
                preconditionFailure(message)
            }
        }
        
    }
    
    func readAllResult<T: Object>(object: T.Type,
                                  completion: @escaping ResultClosure<RealmSwift.Results<T>>) {
        
        ___VARIABLE_optionName___.databaseOperationsQueue.async { [weak self] in
            
            guard let `self` = self else { return }
            
            do {
                let realm = try Realm(configuration: self.configuration)
                completion(.success(realm.objects(T.self)))
            } catch {
                let message: String = "Unable to create realm instance \(error.localizedDescription)"
                ErrorLoggerService.logWithTrace(message)
                preconditionFailure(message)
            }
        }
        
    }
    
    func deleteAll<T: Object>(_ class: T.Type, completion: @escaping VoidClosure) {
        
        ___VARIABLE_optionName___.databaseOperationsQueue.async(flags: .barrier) { [weak self] in
            
            guard let `self` = self else { return }
            
            do {
                let realm = try Realm(configuration: self.configuration)
                let allObjects = realm.objects(T.self)
                try realm.write {
                    realm.delete(allObjects)
                    completion()
                }
            } catch {
                let message: String = error.localizedDescription
                ErrorLoggerService.logWithTrace(message)
                completion()
            }
        }
    }
    
    /**
     Always pass predicate, not the actual objects
     Exception - Can only delete an object from the Realm it belongs to.
     Because of creating another Realm instance on the writing queue
     */
    func delete<T: Object>(predicates: [NSPredicate],
                           objectType: T.Type,
                           completion: @escaping VoidResultClosure) {
        
        ___VARIABLE_optionName___.databaseOperationsQueue.async(flags: .barrier) { [weak self] in
            
            guard let `self` = self else { return }
            
            do {
                let realm = try Realm(configuration: self.configuration)
                
                self.readAllResult(object: T.self, completion: { result in
                    
                    do {
                        
                        switch result {
                        case .success(let objects):
                            
                            var objToDelete = objects
                            for predicate in predicates {
                                objToDelete = objects.filter(predicate)
                            }
                            try realm.write {
                                realm.delete(objToDelete)
                            }
                            
                        case .failure(let error):
                            completion(.failure(error))
                        }
                        
                    } catch {
                        
                        ErrorLoggerService.logWithTrace(error.localizedDescription)
                    }
                    
                })
                
            } catch {
                let message: String = "Unable to create realm instance \(error.localizedDescription)"
                ErrorLoggerService.logWithTrace(message)
            }
        }
    }
    
    func update<T: Object>(value: [T], completion: @escaping VoidClosure) {
        
        for obj in value {
            
            ___VARIABLE_optionName___.shared.writeAsync(obj: obj) { realm, objRef in
                guard let safeObj = objRef else { return }
                do {
                    try realm.write {
                        realm.add(safeObj, update: .modified)
                        completion()
                    }
                } catch {
                    let message: String = error.localizedDescription
                    ErrorLoggerService.logWithTrace(message)
                    completion()
                }
            }
        }
    }
    
    func deleteAllRecords(completion: @escaping VoidClosure) {
        
        ___VARIABLE_optionName___.databaseOperationsQueue.async(flags: .barrier) { [weak self] in
            
            guard let `self` = self else { return }
            
            do {
                let realm = try Realm(configuration: self.configuration)
                try realm.write {
                    realm.deleteAll()
                    completion()
                }
            } catch {
                let message: String = "Unable to create realm instance \(error.localizedDescription)"
                ErrorLoggerService.logWithTrace(message)
                completion()
            }
        }
    }
    
    func isObjectExists<T: Object>(type: T.Type, primaryKey: String) -> Bool {
        
        do {
            let realm = try Realm(configuration: self.configuration)
            return realm.object(ofType: type, forPrimaryKey: primaryKey) != nil
            
        } catch {
            let message: String = "Unable to create realm instance \(error.localizedDescription)"
            ErrorLoggerService.logWithTrace(message)
            preconditionFailure(message)
        }
    }
    
    // NOTE: Implementation from original documentation
    // https://realm.io/docs/swift/latest/#passing-instances-across-threads
    /**
     Thread-safe writing to the Realm
     */
    func writeAsync<T: ThreadConfined>(obj: T, errorHandler: @escaping ((_ error: Swift.Error) -> Void) = { _ in return }, block: @escaping ((Realm, T?) -> Void)) {
        
        let wrappedObj = ThreadSafeReference(to: obj)
        
        ___VARIABLE_optionName___.databaseOperationsQueue.async(flags: .barrier) {
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: RealmDAO.shared.realm.configuration)
                    
                    guard let obj = realm.resolve(wrappedObj) else {
                        return // obj was deleted
                    }
                    
                    try realm.safeWrite {
                        block(realm, obj)
                    }
                } catch {
                    errorHandler(error)
                }
            }
        }
    }
    
}

// MARK: - Database migration functionality
extension ___VARIABLE_optionName___ {
    
    func configureMigration() {
        
        migrationExecutor.performMigrationIfNeeded()
    }
    
    private func getCurrentDatabaseVersion() -> UInt64 {
        
        let configCheck = ___VARIABLE_optionName___.shared.realm.configuration
        guard let fileURL = configCheck.fileURL else {
            let message: String = "Unable to get file url"
            ErrorLoggerService.logWithTrace(message)
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
    
    private func deleteDatabase() {
        let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = configuration
    }
    
}
