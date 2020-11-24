//___FILEHEADER___

import UIKit

protocol ___VARIABLE_tableControllerName___TableControllerDelegate: class {
    
    func didSelectItem(_ item: ___VARIABLE_tableControllerName___TableViewCellVM)
}

final class ___VARIABLE_tableControllerName___CollectionController: NSObject, TableController {
    
    weak var delegate: ___VARIABLE_tableControllerName___TableControllerDelegate?
    
    private lazy var dataSource: [___VARIABLE_tableControllerName___TableViewCellVM] = []
    
    // MARK: - Life cycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override init() {
        super.init()
    }
    
    // MARK: - Public functions
    func update(_ data: [___VARIABLE_tableViewCellDataModel___]) {
        
        dataSource = data.map{
            return ___VARIABLE_tableControllerName___TableViewCellVM(model: $0)
        }
        
    }
    
    // MARK: - Private functions
    
}

// MARK: - UITableViewDataSource
extension ___VARIABLE_tableControllerName___TableController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier: String = ___VARIABLE_tableControllerName___TableViewCell.reuseIdentifier
        guard let cell: ___VARIABLE_collectionControllerName___CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ___VARIABLE_collectionControllerName___CollectionViewCell else {
            let message: String = "Unable to dequeueReusableCell"
            ErrorLoggerService.logWithTrace(message)
            preconditionFailure(message)
        }
        cell.update(dataSource[indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ___VARIABLE_collectionControllerName___TableController {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        delegate?.didSelectItem(dataSource[indexPath.row])
    }
    
}
