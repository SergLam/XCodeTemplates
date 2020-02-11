//___FILEHEADER___

final class InternalAuthConfiguratorFactoryImp: InternalAuthConfiguratorFactory {
    func makeInternalAuthConfigurator() -> InternalAuthConfigurator {
        return InternalAuthConfiguratorImp()
    }
    
    func makeInternalSignUpConfigurator() -> InternalSignUpConfigurator {
        return InternalSignUpConfiguratorImp()
    }
}
