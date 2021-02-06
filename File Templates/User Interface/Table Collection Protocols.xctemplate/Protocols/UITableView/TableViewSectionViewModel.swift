//___FILEHEADER___

import Foundation

// NOTE: Helper struct that avoid two-dimensional array usage inside data source classes
struct TableViewSectionViewModel: TableViewSectionVM {
    
    var header: TableHeaderFooterModel?
    var footer: TableHeaderFooterModel?
    var cells: [TableCellModel] = []
    
    init(header: TableHeaderFooterModel? = nil,
         footer: TableHeaderFooterModel? = nil,
         cells: [TableCellModel]) {
        
        self.header = header
        self.footer = footer
        self.cells = cells
    }
    
}
