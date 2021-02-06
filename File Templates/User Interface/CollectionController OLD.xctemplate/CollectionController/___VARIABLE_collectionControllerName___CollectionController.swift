//___FILEHEADER___

import UIKit

protocol ___VARIABLE_collectionControllerName___CollectionControllerDelegate: class {
    
    func didSelectItem(_ item: ___VARIABLE_collectionControllerName___CollectionViewCellVM)
}

final class ___VARIABLE_collectionControllerName___CollectionController: NSObject, CollectionController {
    
    weak var delegate: ___VARIABLE_collectionControllerName___CollectionControllerDelegate?
    
    private lazy var dataSource: [___VARIABLE_collectionControllerName___CollectionViewCellVM] = []
    
    // MARK: - Life cycle
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override init() {
        super.init()
    }
    
    // MARK: - Public functions
    func update(_ data: [___VARIABLE_collectionViewCellDataModel___]) {
        
        dataSource = data.map{
            return ___VARIABLE_collectionControllerName___CollectionViewCellVM(model: $0)
        }
        
    }
    
    // MARK: - Private functions
    
}

// MARK: - UICollectionViewDataSource
extension ___VARIABLE_collectionControllerName___CollectionController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String = ___VARIABLE_collectionControllerName___CollectionViewCell.reuseIdentifier
        guard let cell: ___VARIABLE_collectionControllerName___CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ___VARIABLE_collectionControllerName___CollectionViewCell else {
            let message: String = "Unable to dequeueReusableCell"
            ErrorLoggerService.logWithTrace(message)
            preconditionFailure(message)
        }
        cell.update(dataSource[indexPath.row])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension ___VARIABLE_collectionControllerName___CollectionController {
    
    func collectionView(_ collectionView: UICollectionView,
           layout collectionViewLayout: UICollectionViewLayout,
           sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width / 3,
                      height: collectionView.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.didSelectItem(dataSource[indexPath.row])
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ___VARIABLE_collectionControllerName___CollectionController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstants.contentInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstants.contentInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return LayoutConstants.contentInsetsHorizontal8
    }
    
}
