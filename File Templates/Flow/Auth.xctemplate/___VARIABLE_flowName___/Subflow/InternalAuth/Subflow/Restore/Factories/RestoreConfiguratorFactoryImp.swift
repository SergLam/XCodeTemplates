//___FILEHEADER___

final class RestoreConfiguratorFactoryImp: RestoreConfiguratorFactory {
    func makeRestoreConfigurator() -> RestoreConfigurator {
        return RestoreConfiguratorImp()
    }
}
