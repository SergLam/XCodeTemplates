//
//  AskQuestionRequest.swift
//  GiftWishesiOS
//
//  Created by Serg Liamthev on 02.01.2020.
//  Copyright © 2020 Serg Liamtsev. All rights reserved.
//

import Foundation
import Moya

struct AskQuestionRequest: Decodable {
    
    var question: String
    
    enum ExternalCodingKeys: String, CodingKey {
        case help = "help"
    }
    
    enum CodingKeys: String, CodingKey {
        case question = "question"
    }
    
    init(question: String) {
        self.question = question
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ExternalCodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .help)
        question = try nestedContainer.decode(String.self, forKey: .question)
    }
    
}

// MARK: - Encodable
extension AskQuestionRequest: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ExternalCodingKeys.self)
        var nestedContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .help)
        try nestedContainer.encode(question, forKey: .question)
    }
    
}

// MARK: - JSONAble
extension AskQuestionRequest: JSONAble {
    
    typealias ReturnType = AskQuestionRequest
    
    func toJSON() -> [String: Any] {
        var result: [String: Any] = [:]
        let nestedDictionary: [String: Any] = [CodingKeys.question.rawValue: question]
        result[ExternalCodingKeys.help.rawValue] = nestedDictionary
        return result
    }
    
    static func fromJSON(_ dictionary: [AnyHashable: Any]) -> AskQuestionRequest? {
        return nil
    }
    
    func toMultipartData() -> [Moya.MultipartFormData]? {
        return nil
    }
    
}

//{
//  "help": {
//    "question": "Work Heroku?"
//  }
//}
