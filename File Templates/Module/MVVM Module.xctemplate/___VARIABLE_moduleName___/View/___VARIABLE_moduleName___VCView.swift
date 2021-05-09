//___FILEHEADER___

import SnapKit
import UIKit

protocol ___VARIABLE_moduleName___VCViewDelegate: AnyObject {
    
}

final class ___VARIABLE_moduleName___VCView: UIView {
    
    weak var delegate: ___VARIABLE_moduleName___VCViewDelegate?
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Private functions
    private func setup() {
        setupLayout()
    }
    
    private func setupLayout() {
        
    }
    
}
