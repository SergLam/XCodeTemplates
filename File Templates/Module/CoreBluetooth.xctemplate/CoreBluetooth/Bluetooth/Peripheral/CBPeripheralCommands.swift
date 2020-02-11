//___FILEHEADER___

import Foundation

extension CBPeripheralService {
    
    func send(data: Data, characteristicUuid: String) {
        guard let characteristic = characteristics[characteristicUuid] else { return }
        peripheralManager?.updateValue(data, for: characteristic, onSubscribedCentrals: nil)
    }
}
