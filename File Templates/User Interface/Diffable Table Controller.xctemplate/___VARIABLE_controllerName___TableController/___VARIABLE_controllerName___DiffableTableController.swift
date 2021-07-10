//___FILEHEADER___

import UIKit

protocol ___VARIABLE_controllerName___DiffableTableControllerDelegate: AnyObject {
    
}

final class ___VARIABLE_controllerName___DiffableTableController: NSObject, DiffableTableController {
    
    weak var delegate: ___VARIABLE_controllerName___DiffableTableControllerDelegate?
    
    enum Section: Int {
        case ___VARIABLE_sectionName___ = 0
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, AnyHashable>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    lazy var dataSource: UITableViewDiffableDataSource<Section, AnyHashable> = makeDataSource()
    
    var sections: [TableViewSectionVM] = [
        // NOTE: - Insert some initial models values if needed
    ]
    
    var factory: TableCellsFactory = ___VARIABLE_controllerName___TableCellsFactory()
    
    var tableView: UITableView
    
    // MARK: - Life cycle
    init(tableView: UITableView) {
        
        self.tableView = tableView
        factory.registerAllCells(for: tableView)
        super.init()
        tableView.delegate = self
        if let factory = self.factory as? ___VARIABLE_controllerName___TableCellsFactory {
            factory.delegate = self
        }
    }
    
    // MARK: - Public functions
    func updateDataSource(with newItems: [TableCellModel], animated: Bool) {
        
    }
    
    // NOTE: - Insert custom data source update methods here
    
    // MARK: - Internal functions
    func makeDataSource() -> UITableViewDiffableDataSource<Section, AnyHashable> {
        
        let dataSource = ___VARIABLE_controllerName___DiffableDataSource(tableView: tableView) { (tableView, index, viewModel) -> UITableViewCell? in
            
            guard let model = viewModel as? TableCellModel else { return nil }
            return self.factory.generateCell(for: model, tableView: tableView, at: index)
        }
        dataSource.controller = self
        return dataSource
    }
    
}

// MARK: - UITableViewDelegate
extension ___VARIABLE_controllerName___DiffableTableController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard sections.indices.contains(indexPath.section) else {
            return CGFloat.leastNonzeroMagnitude
        }
        guard sections[indexPath.section].cells.indices.contains(indexPath.row) else {
            return CGFloat.leastNonzeroMagnitude
        }
        return sections[indexPath.section].cells[indexPath.row].rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard sections.indices.contains(indexPath.section) else {
            return CGFloat.leastNonzeroMagnitude
        }
        guard sections[indexPath.section].cells.indices.contains(indexPath.row) else {
            return CGFloat.leastNonzeroMagnitude
        }
        return sections[indexPath.section].cells[indexPath.row].rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return sections[section].header?.rowHeight ?? CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return sections[section].footer?.rowHeight ?? CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let model: TableHeaderFooterModel = sections[section].header else {
            return nil
        }
        return factory.generateHeader(for: model, tableView: tableView, at: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let model: TableHeaderFooterModel = sections[section].footer else {
            return nil
        }
        return factory.generateFooter(for: model, tableView: tableView, at: section)
    }
    
}

// MARK: - Cell factory delegate
extension ___VARIABLE_controllerName___DiffableTableController: ___VARIABLE_controllerName___TableCellsFactoryDelegate {
   
}
