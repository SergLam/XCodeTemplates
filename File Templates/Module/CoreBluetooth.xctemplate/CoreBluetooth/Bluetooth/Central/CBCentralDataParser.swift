//___FILEHEADER___

import Foundation
import CoreBluetooth

extension CBCentralService {
    
    func getTransferModel(characteristic: CBCharacteristic, data: Data) -> TransferModel? {
        guard let serviceCharacteristic = ServiceCharacteristic(rawValue: characteristic.uuid.uuidString) else { return nil }
        #warning you should realize model creation here
//        switch serviceCharacteristic {
//        case .characteristic: return CharacteristicModel(data: data)
//        }
    }
}
