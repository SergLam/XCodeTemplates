//___FILEHEADER___

import UIKit

protocol ___VARIABLE_controllerName___TableCellsFactoryDelegate: AnyObject {
    
}

final class ___VARIABLE_controllerName___TableCellsFactory: TableCellsFactory {
    
    weak var delegate: ___VARIABLE_controllerName___TableCellsFactoryDelegate?
    
    var cellTypes: [TableViewCell.Type] {
        [
            ___VARIABLE_cellType___.self
        ]
    }
    
    var headerFooterTypes: [TableViewHeaderFooterView.Type] {
        [
            ___VARIABLE_headerFooterType___.self
        ]
    }
    
    func registerAllCells(for tableView: UITableView) {
        
        cellTypes.forEach{
            tableView.register($0.self, forCellReuseIdentifier: $0.reuseIdentifier)
        }
        headerFooterTypes.forEach{
            tableView.register($0.self, forHeaderFooterViewReuseIdentifier: $0.reuseIdentifier)
        }
    }
    
    func generateCell(for viewModel: TableCellModel, tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.type {
        default:
            
            // NOTE: - dequeueReusableCell example = cell update
//            guard let model = viewModel as? MyProfileHeaderTableViewCellVM else {
//                assertionFailure("Invalid model type")
//                return UITableViewCell()
//            }
//            let cell = tableView.dequeueReusableCell(MyProfileHeaderTableViewCell.self, for: indexPath)
//            cell.update(with: model)
//            return cell
            
            assertionFailure("Invalid cell type")
            return UITableViewCell()
        }
    }
    
    func generateHeader(for viewModel: TableHeaderFooterModel, tableView: UITableView, at section: Int) -> UIView? {
        
        switch section {
        case 0:
            
//            let header = tableView.dequeueReusable(headerFooterView: MyPublicationsListHeaderView.self)
//            guard let model = viewModel as? MyPublicationsListHeaderViewVM else {
//                return nil
//            }
//            header.update(with: model)
//            return header
            
            return nil
            
        default:
            return nil
        }
    }
    
    func generateFooter(for viewModel: TableHeaderFooterModel, tableView: UITableView, at section: Int) -> UIView? {
        
        return nil
    }
    
}
