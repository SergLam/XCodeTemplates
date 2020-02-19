//___FILEHEADER___

import Foundation

extension Calendar {
    
    func isDateInCurrentWeek(_ date: Date) -> Bool {
        
        let currentDate = Date()
        guard let startOfWeek = currentDate.startOfWeek, let endOfWeek = currentDate.endOfWeek else {
            let message: String = "Unable to get date"
            ErrorLoggerService.logWithTrace(message)
            return false
        }
        
        if startOfWeek <= date && endOfWeek >= date {
            return true
        } else {
            return false
        }
        
    }
    
    func isDateInCurrentYear(_ date: Date) -> Bool {
        
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: date)
        
        let firstDayOfYearComponents = DateComponents(year: currentYear, month: 1, day: 1, hour: 0, minute: 0, second: 0)
        let lastDayOfYearComponents = DateComponents(year: currentYear, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        
        guard let firstDayOfYear = calendar.date(from: firstDayOfYearComponents),
            let lastDayOfYear = calendar.date(from: lastDayOfYearComponents) else {
            let message: String = "Unable to create date"
            ErrorLoggerService.logWithTrace(message)
            return false
        }
        
        if firstDayOfYear <= date && lastDayOfYear >= date {
            return true
        } else {
            return false
        }
    }
}
