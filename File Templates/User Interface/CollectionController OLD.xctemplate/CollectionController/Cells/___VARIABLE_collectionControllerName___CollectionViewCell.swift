//___FILEHEADER___

import SnapKit
import UIKit

final class ___VARIABLE_collectionControllerName___CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Actions
    
    static let reuseIdentifier: String = String(describing: ___VARIABLE_collectionControllerName___CollectionViewCell.self)
    
    // MARK: - Subviews
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Public functions
    func update(_ model: ___VARIABLE_collectionControllerName___CollectionViewCellVM) {
        
    }
    
    // MARK: - Private functions
    private func setup() {
        
        setupLayout()
    }
    
    private func setupLayout() {
        
    }
    
    // MARK: - Private actions
    
}
