//___FILEHEADER___

import Foundation

enum CollectionCellType: String {
    
    case myProfilePublicationSong
    
}

protocol CollectionCellModel {
    
    var type: CollectionCellType { get }
}
