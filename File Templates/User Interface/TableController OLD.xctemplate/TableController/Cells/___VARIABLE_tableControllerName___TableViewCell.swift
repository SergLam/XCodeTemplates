//___FILEHEADER___

import SnapKit
import UIKit

final class ___VARIABLE_tableControllerName___TableViewCell: UITableViewCell {
    
    // MARK: - Actions
    
    static let reuseIdentifier: String = String(describing: ___VARIABLE_tableControllerName___TableViewCell.self)
    
    // MARK: - Subviews
    
    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    func update(_ model: ___VARIABLE_tableControllerName___TableViewCellVM) {
        
    }
    
    // MARK: - Private functions
    private func setup() {
        
        setupLayout()
    }
    
    private func setupLayout() {
        
    }
    
    // MARK: - Private actions
    
}
