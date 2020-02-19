//___FILEHEADER___

import Foundation

extension Date {
    
     var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
     var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
     static var unixTimeStamp: Int {
        return Int(Date().timeIntervalSince1970)
    }
    
     func getFullDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
     var age: Int {
        
        guard let age = Calendar.current.dateComponents([.year], from: self, to: Date()).year else {
            let message: String = "Unable to fetch age"
            ErrorLoggerService.logWithTrace(message)
            return 0
        }
        return age
        
    }
    
    /**
     Returns an integer from 1 - 7, with 1 being Sunday and 7 being Saturday
     */
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        let engLocale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized(with: engLocale)
    }
    
}
