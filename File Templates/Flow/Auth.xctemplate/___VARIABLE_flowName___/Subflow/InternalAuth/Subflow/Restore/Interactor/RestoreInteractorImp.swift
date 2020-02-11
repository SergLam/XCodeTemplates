//___FILEHEADER___

import Foundation

final class RestoreInteractorImp: BaseInteractor<RestorePresenterImp> ,RestoreInteractor {
	var onRestoreComplete: (() -> Void)?

    func restoreUser(data: RestoreViewUserData) {
        // you should handle this event here
        guard let onRestoreComplete = onRestoreComplete else { return }
        onRestoreComplete()
    }
}
