//___FILEHEADER___

import Foundation

final class PredicateBuilder {
    
    // MARK: field names - equal to realm Object fields names
    static let chatIdFieldName = "chatId"
    
    static let messageIdFieldName = "id"
    
    static let isIncomingMessagePredicate = PredicateBuilder.equalityPredicate(messageIsIncomingFieldName, true)
    
    static let questionUpdatePredicateFormat = "\(PredicateBuilder.questionIdFieldName) IN %@ AND \(PredicateBuilder.chatIdFieldName) IN %@"
    
    // MARK: - Predicate creation methods
    static func equalityPredicate(_ fieldName: String, _ value: Any) -> NSPredicate {
        return NSPredicate(format: "\(fieldName) == %@", argumentArray: [value])
    }
    
    static func notEqualPredicate(_ fieldName: String, _ value: Any) -> NSPredicate {
        return NSPredicate(format: "\(fieldName) != %@", argumentArray: [value])
    }
    
    static func buildPredicate(_ format: String, _ value: [Any]) -> NSPredicate {
        return NSPredicate(format: format, argumentArray: value)
    }
    
    static func nilPredicate(_ fieldName: String) -> NSPredicate {
        return NSPredicate(format: "\(fieldName) == nil")
    }
    
}
