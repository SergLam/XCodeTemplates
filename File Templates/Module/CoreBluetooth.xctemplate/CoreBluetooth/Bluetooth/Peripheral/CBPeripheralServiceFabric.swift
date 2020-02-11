//___FILEHEADER___

import CoreBluetooth

typealias CBProperties = (services:[CBMutableService], characteristic:[CBMutableCharacteristic]?)


class CBPeripheralServiceFabric {
    
    static func serviceProperties() -> CBProperties {
        let firstService = CBPeripheralServiceFabric.firstService()
        let firstServiceCharacteristics = CBPeripheralServiceFabric.firstServiceCharacteristics()
        firstService.characteristics = firstServiceCharacteristics
        return ([firstService], firstServiceCharacteristics)
    }
    
    private static func firstService() -> CBMutableService {
        let firstService = CBMutableService(type: CBUUID(string: CBConstatnts.FirstService.uuid), primary: true)
        return firstService
    }
    
    private static func firstServiceCharacteristics() -> [CBMutableCharacteristic]? {
        var characteristics = [CBMutableCharacteristic]()
        guard let availableCharacteristics = CBConstatnts.availableServices[CBConstatnts.FirstService.uuid]?.availableCharacteristic else { return nil }
        
        for uuid in availableCharacteristics {
            characteristics.append(CBMutableCharacteristic(type: CBUUID(string: uuid), properties: .notify, value: nil, permissions: .readable))
        }
        return characteristics
    }
}
