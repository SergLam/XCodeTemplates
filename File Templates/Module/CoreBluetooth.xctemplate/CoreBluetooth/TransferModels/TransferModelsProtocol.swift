//___FILEHEADER___

import Foundation

enum TransferModelType {
}

protocol TransferModel where Self: Codable {
    var modelType: TransferModelType { get set }
    func getData() -> Data?
    init(data: Data)
}

protocol TransferModelObserverProtocol: NSObject {
    func updateModel(model: TransferModel)
}
