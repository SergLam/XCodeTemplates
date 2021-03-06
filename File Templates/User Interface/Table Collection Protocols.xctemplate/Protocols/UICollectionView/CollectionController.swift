//___FILEHEADER___

import UIKit

protocol CollectionSectionVM {
    
    var header: CollectionHeaderFooterModel? { get set }
    var footer: CollectionHeaderFooterModel? { get set }
    var cells: [CollectionCellModel] { get set }
}

protocol CollectionController: NSObject, UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout {
    
    var updatesQueue: DispatchQueue { get set }
    
    var dataSource: [CollectionSectionVM] { get set }
    
    var factory: CollectionCellsFactory { get set }
    
    var collectionView: UICollectionView { get set }
    
    init(collectionView: UICollectionView)
    
    func updateDataSource(with newItems: [CollectionCellModel], animated: Bool)
    
}
