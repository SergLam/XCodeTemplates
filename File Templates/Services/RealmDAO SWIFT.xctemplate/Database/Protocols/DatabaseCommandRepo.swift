//___FILEHEADER___

import Foundation
import RealmSwift

protocol DatabaseCommandRepo {
    
    var config: Realm.Configuration { get set }
    
    var commandQueue: DispatchQueue { get set }
    
}
