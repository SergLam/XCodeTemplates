//___FILEHEADER___

import Foundation

extension UserDefaults {
    
    static let shared = UserDefaults.standard
    
    var accessToken: String? {
        get {
            return UserDefaults.standard.value(forKey: UserDefaultsKeys.accessToken.rawValue) as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKeys.accessToken.rawValue)
        }
    }
    
    func setDefaultValues() {

        UserDefaults.standard.accessToken = nil
    }
}
