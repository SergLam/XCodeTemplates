//___FILEHEADER___

protocol CoordinatorFactory {
    func makeMainCoordinator(router: Router) -> Coordinator & CoordinatorOutput
}
