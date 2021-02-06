//___FILEHEADER___

import UIKit

final class ___VARIABLE_controllerName___DiffableDataSource: UITableViewDiffableDataSource<___VARIABLE_controllerName___DiffableTableController.Section, AnyHashable> {
    
    weak var controller: ___VARIABLE_controllerName___DiffableTableController?
    
    // MARK: - Life cycle
    override init(tableView: UITableView,
                  cellProvider: @escaping UITableViewDiffableDataSource<___VARIABLE_controllerName___DiffableTableController.Section, AnyHashable>.CellProvider) {

        super.init(tableView: tableView, cellProvider: cellProvider)
        self.defaultRowAnimation = .automatic
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return controller?.sections.filter{ !$0.cells.isEmpty }.count ?? 0
    }
    
}
