//___FILEHEADER___

import Foundation
import CoreBluetooth

extension CBCentralService: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
            case .poweredOn:
                print("bluetooth is ON")
                startScan()
                self.observerController?.bluetoothOn()
            default:
                print("bluetooth is OFF (\(central.state.rawValue))")
                self.stopScan()
                self.disconnect()
                self.observerController?.bluetoothOff()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard peripheral.name != nil && (peripheral.name?.hasPrefix("Panorama"))! else { return }
        print("discovered peripheral: \(peripheral.name!)")
        foundPeripherals.add(peripheral)
        self.observerController?.discoveredPeripheral(peripherals: foundPeripherals)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if let periperalName = peripheral.name {
            print("connected to: \(periperalName)")
        } else {
            print("connected to peripheral")
        }
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        self.observerController?.connected(name: peripheral.name)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("peripheral disconnected")
        self.characteristics.removeAll()
        self.observerController?.disconnected(failure: false)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("failed to connect: \(error.debugDescription)")
        self.characteristics.removeAll()
        self.observerController?.disconnected(failure: true)
    }
}
