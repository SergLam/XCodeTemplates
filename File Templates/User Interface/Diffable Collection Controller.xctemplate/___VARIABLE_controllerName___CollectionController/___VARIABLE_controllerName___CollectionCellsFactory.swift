//___FILEHEADER___

import UIKit

protocol ___VARIABLE_controllerName___CollectionCellsFactoryDelegate: AnyObject {
    
}

final class ___VARIABLE_controllerName___CollectionCellsFactory: CollectionCellsFactory {
    
    weak var delegate: ___VARIABLE_controllerName___CollectionCellsFactoryDelegate?
    
    var cellTypes: [CollectionViewCell.Type] {
        [
            ___VARIABLE_cellType___.self
        ]
    }
    
    var headerFooterTypes: [CollectionViewHeaderFooterView.Type] {
        [
            ___VARIABLE_headerFooterType___.self
        ]
    }
    
    func registerAllCells(for collectionView: UICollectionView) {
        
        cellTypes.forEach{
            let bundle = Bundle(for: $0)
            let nib = UINib(nibName: $0.reuseIdentifier, bundle: bundle)
            collectionView.register(nib, forCellWithReuseIdentifier: $0.reuseIdentifier)
        }
        headerFooterTypes.forEach{
            let bundle = Bundle(for: $0)
            let nib = UINib(nibName: $0.reuseIdentifier, bundle: bundle)
            collectionView.register(nib, forSupplementaryViewOfKind: $0.viewType, withReuseIdentifier: $0.reuseIdentifier)
        }
    }
    
    func generateCell(for viewModel: CollectionCellModel,
                      collectionView: UICollectionView,
                      at indexPath: IndexPath) -> UICollectionViewCell {
        
        switch viewModel.type {
        default:
            
            // NOTE: - dequeueReusableCell example = cell update
//            guard let model = viewModel as? <MODEL_TYPE> else {
//                assertionFailure("Invalid model type")
//                return UICollectionViewCell()
//            }
            
            let cell = collectionView.dequeueReusableCell(___VARIABLE_cellType___.self, for: indexPath)
            // cell.configureWithModel(model)
            return cell
            
        }
        
    }
    
    func generateHeader(for viewModel: CollectionHeaderFooterModel?,
                        collectionView: UICollectionView,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        case 0:
            
            let type: String = ___VARIABLE_headerFooterType___.viewType
            let header = collectionView.dequeueSupplementaryView(___VARIABLE_headerFooterType___.self, ofKind: type, for: indexPath)
            return header
            
        default:
            
            return UICollectionReusableView()
        }
    }
    
    func generateFooter(for viewModel: CollectionHeaderFooterModel?,
                        collectionView: UICollectionView,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch indexPath.section {
        default:
            return UICollectionReusableView()
        }
    }
    
}
