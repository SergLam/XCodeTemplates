//___FILEHEADER___

import Kingfisher
import UIKit

extension UIImageView {
    
    func setImageFromURL(_ stringURL: String, _ placeholder: UIImage? = nil) {
        guard let url = URL(string: stringURL) else {
            return
        }
        kf.setImage(with: url, placeholder: placeholder,
                    options: [.transition(.fade(0.1)),
                              .forceTransition,
                              .keepCurrentImageWhileLoading,
                              .cacheOriginalImage]) { [weak self] result in
                                
                                switch result {
                                    
                                case .success(let data):
                                    
                                    self?.image = data.image
                                    self?.layoutIfNeeded()
                                    
                                case .failure:
                                    self?.image = nil
                                    self?.layoutIfNeeded()
                                }
        }
    }
    
}
