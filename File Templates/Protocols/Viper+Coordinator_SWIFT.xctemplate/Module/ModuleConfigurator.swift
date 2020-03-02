//___FILEHEADER___

import Foundation

protocol ModuleConfigurator {
    associatedtype ModuleType
    static func makeModule() -> ModuleType
}
