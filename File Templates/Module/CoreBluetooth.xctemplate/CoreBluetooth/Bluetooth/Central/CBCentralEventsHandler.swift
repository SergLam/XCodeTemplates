//___FILEHEADER___

import Foundation
import CoreBluetooth

extension CBCentralService: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        
        for service in services {
            let serviceUuid = service.uuid.uuidString
            if CBConstatnts.availableServices.keys.contains(serviceUuid) {
                print("discovered service: \(serviceUuid)")
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            let characteristicUuid = characteristic.uuid.uuidString
            guard let serviceAvailable = CBConstatnts.availableServices[service.uuid.uuidString] else { return }
            if serviceAvailable.availableCharacteristic.contains(characteristicUuid) {
                peripheral.setNotifyValue(true, for: characteristic)
                self.characteristics[characteristicUuid] = characteristic
            }
        }
        if self.characteristics.count > 0 {
            self.observerController?.readyToWrite()
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
          //  print("didUpdateValueFor \(characteristic.uuid.uuidString) = count: \(data.count) | \(self.hexEncodedString(data))")
            guard let model: TransferModel = getTransferModel(characteristic: characteristic, data: data) else {
                print("didUpdateValueFor \(characteristic.uuid.uuidString) with no model")
                return
            }
            self.observerController?.received(model: model)
        } else {
            print("didUpdateValueFor \(characteristic.uuid.uuidString) with no data")
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            print("error while writing value to \(characteristic.uuid.uuidString): \(error.debugDescription)")
        } else {
            print("didWriteValueFor \(characteristic.uuid.uuidString)")
        }
    }
    
    private func hexEncodedString(_ data: Data?) -> String {
        let format = "0x%02hhX "
        return data?.map { String(format: format, $0) }.joined() ?? ""
    }
}

