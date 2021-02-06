//___FILEHEADER___

import Foundation

// NOTE: Helper struct that avoid two-dimensional array usage inside data source classes
struct CollectionViewSectionViewModel: CollectionSectionVM {
    
    var header: CollectionHeaderFooterModel?
    var footer: CollectionHeaderFooterModel?
    var cells: [CollectionCellModel] = []
    
    init(header: CollectionHeaderFooterModel? = nil,
         footer: CollectionHeaderFooterModel? = nil,
         cells: [CollectionCellModel]) {
        
        self.header = header
        self.footer = footer
        self.cells = cells
    }
    
}
