//___FILEHEADER___

import Foundation

enum CollectionHeaderFooterType: Int {
    
    case myProfile = 0
}

protocol CollectionHeaderFooterModel {
    
    var type: CollectionHeaderFooterType { get }
}
