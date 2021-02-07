//___FILEHEADER___

import UIKit

protocol ___VARIABLE_controllerName___DiffableCollectionControllerDelegate: class {
    
}

final class ___VARIABLE_controllerName___DiffableCollectionController: NSObject, DiffableCollectionController {
    
    weak var delegate: ___VARIABLE_controllerName___DiffableCollectionControllerDelegate?
    
    enum Section: Int {
        case ___VARIABLE_sectionName___ = 0
    }
    
    typealias DataSource = ___VARIABLE_controllerName___DiffableDataSource
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    lazy var dataSource: DataSource = makeDataSource()
    
    var sections: [CollectionSectionVM] = [
        CollectionViewSectionViewModel(cells: [])
    ]
    
    var factory: CollectionCellsFactory = ___VARIABLE_controllerName___CollectionCellsFactory()
    
    var collectionView: UICollectionView
    
    private lazy var lastContentOffset: CGFloat = 0
    
    private lazy var itemSpacing: CGFloat = 11.0
    
    private lazy var collectionInset: CGFloat = LayoutConstants.spacing
    
    // MARK: - Life cycle
    init(collectionView: UICollectionView) {
        
        self.collectionView = collectionView
        factory.registerAllCells(for: collectionView)
        super.init()
        collectionView.delegate = self
        if let factory = self.factory as? ___VARIABLE_controllerName___CollectionCellsFactory {
            factory.delegate = self
        }
    }
    
    // MARK: - Public functions
    func updateDataSource(with newItems: [CollectionCellModel], animated: Bool) {
        
    }
    
    // NOTE: - Insert custom data source update methods here
    
    // MARK: - Internal / private functions
    func makeDataSource() -> DataSource {
        
        let dataSource = ___VARIABLE_controllerName___DiffableDataSource(collectionView: collectionView) { collectionView, index, viewModel -> UICollectionViewCell? in
            
            guard let model = viewModel as? CollectionCellModel else { return nil }
            return self.factory.generateCell(for: model, collectionView: collectionView, at: index)
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                
                let model = self.sections[indexPath.section].header
                let header = self.factory.generateHeader(for: model, collectionView: collectionView, at: indexPath)
                return header
                
            case UICollectionView.elementKindSectionFooter:
                
                let model = self.sections[indexPath.section].footer
                let footer = self.factory.generateFooter(for: model, collectionView: collectionView, at: indexPath)
                return footer
                
            default:
                assertionFailure("Unknown view type")
                return nil
            }
        }
        dataSource.controller = self
        return dataSource
    }
    
}

// MARK: - UICollectionViewDelegate
extension ___VARIABLE_controllerName___DiffableCollectionController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // TODO: - Call delegate method here
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ___VARIABLE_controllerName___DiffableCollectionController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 140, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0.0, left: collectionInset, bottom: 0.0, right: collectionInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        // NOTE: - Return non-zero size to display section header
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        // NOTE: - Return non-zero size to display section footer
        return CGSize.zero
    }
    
}

// MARK: - Cell factory delegate
extension ___VARIABLE_controllerName___DiffableCollectionController: ___VARIABLE_controllerName___CollectionCellsFactoryDelegate {
    
}
