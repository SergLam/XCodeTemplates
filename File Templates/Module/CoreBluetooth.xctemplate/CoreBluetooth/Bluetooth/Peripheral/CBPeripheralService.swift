//___FILEHEADER___

import UIKit
import CoreBluetooth


struct BluetoothPeripheral {
    let localName: String
    let uuid: String
    
    func peripheralData() -> [String : Any] {
        return [
            CBAdvertisementDataLocalNameKey    : localName,
            CBAdvertisementDataServiceUUIDsKey : [CBUUID(string: uuid)]]
    }
}

class CBPeripheralService: NSObject {
    
    var peripheralManager: CBPeripheralManager?
    
    var characteristics = [String : CBMutableCharacteristic]()
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func startAdvertising() {
        let properties = CBPeripheralServiceFabric.serviceProperties()
        
        for service in properties.services {
           peripheralManager?.add(service)
        }
        
        if let characteristics = properties.characteristic {
            for characteristic in characteristics {
                self.characteristics[characteristic.uuid.uuidString] = characteristic
            }
        }
        
        peripheralManager?.startAdvertising(BluetoothPeripheral(localName: CBConstatnts.localName, uuid: UIDevice.current.identifierForVendor!.uuidString).peripheralData())
    }
}
