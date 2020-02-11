//___FILEHEADER___

import CoreBluetooth

protocol PeripheralService {
    static var uuid: String { get }
    var availableCharacteristic: [String] { get }
}

enum ServiceCharacteristic: String {
    case characteristic = "UUID"
}

struct CBConstatnts {
    static let localName = "LocalName"
    
    struct FirstService: PeripheralService {
        static let uuid: String = "UUID"
        let availableCharacteristic: [String] = [ServiceCharacteristic.characteristic.rawValue]
    }
    
    static let availableServices: [String : PeripheralService] = [FirstService.uuid : FirstService()]
}

