//___FILEHEADER___

import Foundation

extension Double {
    
    func roundedString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 0

        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func percentFormatted(locale: Locale = Locale.current) -> String {
        
        let number = NSNumber(value: self / 100)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.locale = locale
        return numberFormatter.string(from: number) ?? ""
    }
    
    func moneyFormatted(locale: Locale = Locale.current) -> String {
        
        let number = NSNumber(value: self)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.locale = locale
        return numberFormatter.string(from: number) ?? ""
    }
    
}
