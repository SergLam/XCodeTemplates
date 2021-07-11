//___FILEHEADER___

import Foundation
import RealmSwift

protocol DatabaseQueryRepo {
    
    var config: Realm.Configuration { get set }
    
    var queryQueue: DispatchQueue { get set }
    
}
