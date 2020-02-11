//___FILEHEADER___

import Foundation

final class GoogleAuthConfiguratorFactoryImp: GoogleAuthConfiguratorFactory {
    func makeAuthConfigurator() -> GoogleAuthConfigurator {
        return GoogleAuthConfiguratorImp()
    }
}
