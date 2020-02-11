//___FILEHEADER___

import Foundation

final class MainInteractorImp: BaseInteractor<MainPresenterImp>, MainInteractor {
	var onMainComplete: (() -> Void)?

    func signOutButtonPressed() {
        guard let onMainComplete = onMainComplete else { return }
        onMainComplete()
    }
}
