//___FILEHEADER___

import Foundation

protocol ModuleConfigurator: ModuleDataModel {
    
    associatedtype ModuleType
    associatedtype ModelType
    
    static func makeModule(with model: ModelType) -> ModuleType
}
