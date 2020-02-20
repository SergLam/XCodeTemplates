//___FILEHEADER___

import Foundation

protocol Mockable {
    associatedtype MockType
    
    static func mock() -> MockType
    
    static func mockArray(_ count: Int) -> [MockType]
}
