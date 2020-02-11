//___FILEHEADER___

import Foundation

final class FacebookAuthConfiguratorFactoryImp: FacebookAuthConfiguratorFactory {
    func makeAuthConfigurator() -> FacebookAuthConfigurator {
        return FacebookAuthConfiguratorImp()
    }
}
