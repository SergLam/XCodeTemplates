//___FILEHEADER___

import UIKit

protocol DiffableCollectionController: NSObject, UICollectionViewDelegate & UICollectionViewDelegateFlowLayout {
    
    // NOTE: Protocol 'DiffableCollectionController' can only be used as a generic constraint because it has Self or associated type requirements
    associatedtype DataSource = UICollectionViewDiffableDataSource<AnyHashable, AnyHashable>
    associatedtype Snapshot = NSDiffableDataSourceSnapshot<AnyHashable, AnyHashable>
    
    var dataSource: DataSource { get set }
    
    var sections: [CollectionSectionVM] { get set }
    
    var factory: CollectionCellsFactory { get set }
    
    var collectionView: UICollectionView { get set }
    
    init(collectionView: UICollectionView)
    
    func makeDataSource() -> DataSource
    
    func updateDataSource(with newItems: [CollectionCellModel], animated: Bool)
    
}
