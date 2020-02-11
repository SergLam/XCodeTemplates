//___FILEHEADER___

import Foundation
import CoreBluetooth

protocol CBCentralObserver {
    func bluetoothOn()
    func bluetoothOff()
    func scanStarted()
    func scanStopped()
    func connected(name: String?)
    func disconnected(failure: Bool)
    func discoveredPeripheral(peripherals: NSOrderedSet)
    func readyToWrite()
    func received(model: TransferModel)
    // TODO: add other events if needed
}

extension CBCentralObserver {
    func bluetoothOn() { }
    func bluetoothOff() { }
    func scanStarted() { }
    func scanStopped() { }
    func connected(name: String?) { }
    func disconnected(failure: Bool) { }
    func discoveredPeripheral(peripherals: NSOrderedSet) { }
    func readyToWrite() { }
    func received(model: TransferModel) { }
}
