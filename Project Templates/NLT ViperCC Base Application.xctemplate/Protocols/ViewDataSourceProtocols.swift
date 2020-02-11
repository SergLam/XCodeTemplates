//___FILEHEADER___

import Foundation

protocol BaseViewDataSource { }

protocol DataReturnable {
    associatedtype DataSource: BaseViewDataSource
    var viewData: DataSource? { get }
}
