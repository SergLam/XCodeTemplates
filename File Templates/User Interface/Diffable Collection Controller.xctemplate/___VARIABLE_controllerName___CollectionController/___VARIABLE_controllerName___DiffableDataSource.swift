//___FILEHEADER___

import UIKit

final class ___VARIABLE_controllerName___DiffableDataSource: UICollectionViewDiffableDataSource<___VARIABLE_controllerName___DiffableCollectionController.Section, AnyHashable> {
    
    weak var controller: ___VARIABLE_controllerName___DiffableCollectionController?
    
    // MARK: - Life cycle
    override init(collectionView: UICollectionView,
                  cellProvider: @escaping UICollectionViewDiffableDataSource<___VARIABLE_controllerName___DiffableCollectionController.Section, AnyHashable>.CellProvider) {

        super.init(collectionView: collectionView, cellProvider: cellProvider)
    }
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        super.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
    
}
