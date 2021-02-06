//___FILEHEADER___

import UIKit

enum TableHeaderFooterType: Int {
    
    case myProfilePublicationsCount = 0
}

protocol TableHeaderFooterModel {
    
    var type: TableHeaderFooterType { get }
    
    var rowHeight: CGFloat { get } // UITableView.automaticDimension if your cell should have content-dependent height
}
