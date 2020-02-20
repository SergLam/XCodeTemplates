//___FILEHEADER___

import Alamofire
import Foundation
import Moya
import Rswift

let API = MoyaProvider<___PROJECTNAME___>(session: CustomAlamofireSession.defaultAlamofireSession(),
                                plugins: provideNetworkPlugin())

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}

private func JSONRequestDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        guard let result = String(data: prettyData, encoding: String.Encoding.utf8) else {
            return String(decoding: data, as: UTF8.self)
        }
        return result
    } catch {
        return String(decoding: data, as: UTF8.self)
    }
}

private func provideNetworkPlugin() -> [PluginType] {
    #if DEBUG
    return [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONRequestDataFormatter),
                                                     logOptions: .verbose))]
    #else
    return []
    #endif
}

enum ___PROJECTNAME___: TargetType {
        
    // MARK: - Sign in flow requests
    case signIn
    case signUp
    
    var baseURL: URL {
        switch self {
            // TODO: - Insert base URL here
            return URL(string: "https://www.google.com/") ?? URL(fileURLWithPath path: "")
        }
    }
    
    var path: String {
        
        switch self {
        case .signIn:
            return "/auth/sign_in"
        case .signUp:
            return "/auth/sign_up"
        }
    }
    
    var method: Moya.Method {
        switch self {
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [:]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
}
