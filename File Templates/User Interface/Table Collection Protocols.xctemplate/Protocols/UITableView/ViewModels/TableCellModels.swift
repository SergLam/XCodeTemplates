//___FILEHEADER___

import UIKit

enum TableCellType: String {
    
    case myProfileHeader

}

protocol TableCellModel {
    
    var type: TableCellType { get }
    
    var rowHeight: CGFloat { get } // UITableView.automaticDimension if your cell should have content-dependent height

}
