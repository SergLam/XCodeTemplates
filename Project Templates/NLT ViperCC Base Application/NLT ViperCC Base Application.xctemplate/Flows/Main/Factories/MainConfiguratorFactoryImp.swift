//___FILEHEADER___

final class MainConfiguratorFactoryImp: MainConfiguratorFactory {
    func makeMainConfigurator() -> MainConfigurator {
        return MainConfiguratorImp()
    }
}
