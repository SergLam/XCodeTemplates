//___FILEHEADER___

import UIKit

protocol ___VARIABLE_controllerName___CollectionControllerDelegate: class {
    
}

final class ___VARIABLE_controllerName___CollectionController: NSObject, CollectionController {
    
    weak var delegate: ___VARIABLE_controllerName___CollectionControllerDelegate?
    
    var updatesQueue: DispatchQueue = DispatchQueue(label: "\(Environment.bundleId).collection.updates.\(String(describing: ___VARIABLE_controllerName___CollectionController.self))", qos: .userInteractive, attributes: [], autoreleaseFrequency: .workItem, target: nil)
    
    var dataSource: [CollectionSectionVM] = [
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
        collectionView.dataSource = self
        if let factory = self.factory as? ___VARIABLE_controllerName___CollectionCellsFactory {
            factory.delegate = self
        }
    }
    
    // MARK: - Public functions
    func updateDataSource(with newItems: [CollectionCellModel], animated: Bool) {
        
        // NOTE: - Update your data source using internal queue to avoid NSInternalInconsistencyException. Change to diffable data source if needed
        updatesQueue.async {
            
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension ___VARIABLE_controllerName___CollectionController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return dataSource[section].cells.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return dataSource.filter{ !$0.cells.isEmpty }.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = dataSource[indexPath.section].cells[indexPath.row]
        return self.factory.generateCell(for: model, collectionView: collectionView, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let model = dataSource[indexPath.section].header
            let header = factory.generateHeader(for: model, collectionView: collectionView, at: indexPath)
            return header
            
        case UICollectionView.elementKindSectionFooter:
            
            let model = dataSource[indexPath.section].footer
            let footer = factory.generateFooter(for: model, collectionView: collectionView, at: indexPath)
            return footer
            
        default:
            assertionFailure("Unknown view type")
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        canMoveItemAt indexPath: IndexPath) -> Bool {
        
        return false
    }
    
}

// MARK: - UICollectionViewDelegate
extension ___VARIABLE_controllerName___CollectionController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // TODO: - Call delegate method here
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ___VARIABLE_controllerName___CollectionController: UICollectionViewDelegateFlowLayout {
    
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
extension ___VARIABLE_controllerName___CollectionController: ___VARIABLE_controllerName___CollectionCellsFactoryDelegate {
    
}
