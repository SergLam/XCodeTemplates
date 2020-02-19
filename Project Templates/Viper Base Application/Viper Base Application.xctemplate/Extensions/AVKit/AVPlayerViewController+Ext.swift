//___FILEHEADER___

import AVKit

extension AVPlayerViewController {
    
    open override var shouldAutorotate: Bool {
        return true
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
}
