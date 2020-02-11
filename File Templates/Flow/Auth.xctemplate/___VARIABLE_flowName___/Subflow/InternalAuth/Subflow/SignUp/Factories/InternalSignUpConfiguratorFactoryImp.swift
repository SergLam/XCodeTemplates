//___FILEHEADER___

final class InternalSignUpConfiguratorFactoryImp: InternalSignUpConfiguratorFactory {
    func makeInternalSignUpConfigurator() -> InternalSignUpConfigurator {
        return InternalSignUpConfiguratorImp()
    }
}
