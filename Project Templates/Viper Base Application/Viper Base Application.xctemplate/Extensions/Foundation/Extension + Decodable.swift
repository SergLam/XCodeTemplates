//___FILEHEADER___

import Foundation

extension KeyedDecodingContainer {
    
     func nestedContainerIfPresent<NestedKey>(keyedBy type: NestedKey.Type, forKey key: KeyedDecodingContainer<K>.Key) -> KeyedDecodingContainer<NestedKey>? where NestedKey: CodingKey {
        
        do {
            return try nestedContainer(keyedBy: type, forKey: key)
        } catch {
            return nil
        }
    }
}
