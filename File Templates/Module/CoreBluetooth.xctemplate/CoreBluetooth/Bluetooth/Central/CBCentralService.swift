//___FILEHEADER___

import UIKit
import CoreBluetooth

class CBCentralService: NSObject {
    var centralManager: CBCentralManager!
    
    var foundPeripherals: NSMutableOrderedSet = NSMutableOrderedSet()
    
    var peripheral: CBPeripheral?
    
    var characteristics = [String : CBCharacteristic]()
    
    var bluetoothState: CBManagerState {
        return self.centralManager.state
    }
    
    var observerController: CBCentralObserver?
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScan() {
        self.peripheral = nil
        guard self.centralManager.state == .poweredOn else { return }

        self.centralManager.scanForPeripherals(withServices: [])
        self.observerController?.scanStarted()
        print("scan started")
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.stopScan()
        }
    }
    
    func stopScan() {
        self.centralManager.stopScan()
        self.observerController?.scanStopped()
        print("scan stopped\n")
    }
    
    func connect() {
        guard self.centralManager.state == .poweredOn else { return }
        guard let peripheral = self.peripheral else { return }
        self.centralManager.connect(peripheral)
    }
    
    func disconnect() {
        guard let peripheral = self.peripheral else { return }
        self.centralManager.cancelPeripheralConnection(peripheral)
    }
}

