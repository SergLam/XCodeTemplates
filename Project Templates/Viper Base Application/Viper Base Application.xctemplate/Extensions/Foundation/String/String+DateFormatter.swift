//___FILEHEADER___

import Foundation

extension String {
    
    static let dateFormatter = DateFormatter()
    static let calendar = Calendar.current
    
    //    Time stamp (in local time of device):
    //    Last 24 hours – time presented in the device defined format (17:40 / 5:40 PM)
    //    Yesterday – “Yesterday”
    //    Last week – “Sunday” / “Monday”…
    //    Current calendar year – “25 Oct”
    //    Previous calendar years – date in the device defined format (24/05/2017 or 05/24/2017)
    
    static func getDate(time: TimeInterval) -> String {
        
        let date = Date(timeIntervalSince1970: time)
        dateFormatter.locale = Locale.current
        
        if calendar.isDateInToday(date) {
            
            return getTimeFromDate(date)
        } else if calendar.isDateInYesterday(date) {
            
            return Localizable.dateYesterday()
        } else if calendar.isDateInCurrentWeek(date) {
            
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
            
        } else if calendar.isDateInCurrentYear(date) {
            dateFormatter.dateFormat = "d MMM"
            return dateFormatter.string(from: date)
            
        } else {
            
            dateFormatter.dateStyle = .short
            return dateFormatter.string(from: date)
        }
    }
    
    static func getTimeFromDate(_ date: Date) -> String {
        
        let locale = NSLocale.current
        guard let formatter: String = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale) else {
            let message: String = "Unable to get dateFormat"
            ErrorLoggerService.logWithTrace(message)
            return ""
        }
        if formatter.contains("a") {
            dateFormatter.dateFormat = "h:mm a"
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
        } else {
            dateFormatter.dateFormat = "HH:mm"
        }
        return dateFormatter.string(from: date)
    }
    
}
