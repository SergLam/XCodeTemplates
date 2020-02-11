//___FILEHEADER___

import Foundation

protocol ___VARIABLE_flowName___User {
    var authOption: ___VARIABLE_flowName___Option { get set }
    var accessData: NSSecureCoding? { get set }
    var email: String? { get set }
}

struct ___VARIABLE_flowName___UserImp: ___VARIABLE_flowName___User {
    var authOption: ___VARIABLE_flowName___Option
    var accessData: NSSecureCoding?
    var email: String?
}
