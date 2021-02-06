//___FILEHEADER___

import UIKit

protocol TableViewCell: UITableViewCell {
    
}

protocol TableViewHeaderFooterView: UITableViewHeaderFooterView {
    
}

protocol TableCellsFactory {
    
    var cellTypes: [TableViewCell.Type] { get }
    
    var headerFooterTypes: [TableViewHeaderFooterView.Type] { get }
    
    func registerAllCells(for tableView: UITableView)
    
    func generateCell(for viewModel: TableCellModel, tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    
    func generateHeader(for viewModel: TableHeaderFooterModel, tableView: UITableView, at section: Int) -> UIView?
    
    func generateFooter(for viewModel: TableHeaderFooterModel, tableView: UITableView, at section: Int) -> UIView?
    
}
