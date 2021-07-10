//___FILEHEADER___

import Foundation
import Moya

typealias DataUpdateInfo = [String: [String: Any]]

protocol JSONAble where Self: Codable {
    
    func toJSON() -> [String: Any]
    static func fromJSON(_ dictionary: [AnyHashable: Any]) -> Self?
    func toMultipartData() -> [Moya.MultipartFormData]?
}

extension JSONAble {
    
    func toJSON() -> [String: Any] {
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(self),
           let jsonString = String(data: jsonData, encoding: String.Encoding.utf8),
           let jsonDict = jsonString.toDictionary() {
            return jsonDict
        }
        return [:]
    }
    
    static func fromJSON(_ dictionary: [AnyHashable: Any]) -> Self? {
        if let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []),
           let result = try? fromData(data) {
            return result
        }
        return nil
    }
    
    static func fromData(_ data: Data) throws -> Self {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(Self.self, from: data)
            return object
        } catch {
            print("Decode \(String(describing: self)) error")
            throw error
        }
    }
}

extension JSONAble {
    
    func toDataUpdate() -> DataUpdateInfo {
        return [String(describing: Self.Type.self): self.toJSON()]
    }
    
    static func fromDataUpdate(_ data: DataUpdateInfo) -> Self? {
        guard let dict = data[String(describing: Self.Type.self)] else {
            return nil
        }
        return Self.fromJSON(dict)
    }
    
}

extension String {
    
    public func toDictionary() -> [String: Any]? {
       if let data = self.data(using: .utf8) {
           do {
               let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
               return json
           } catch {
            print("Encode \(String(describing: self)) error")
           }
       }
       return nil
   }
    
}

extension JSONAble {
    
    static var objectName: String {
        return String(describing: self)
    }
    
    static func fromNotification(_ notification: NSNotification) -> Self? {
        guard let info = notification.userInfo else {
            return nil
        }
        
        return Self.fromJSON(info)
    }
    
}

extension JSONAble where Self: Encodable {
    
    func toJSONString() -> String? {
        do {
            let encoder = JSONEncoder()
            // encoder.outputFormatting = .sortedKeys
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            ErrorLoggerService.logWithTrace(error: error)
            return nil
        }
    }
    
}
