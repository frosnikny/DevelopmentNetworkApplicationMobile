//
//  APIErrors.swift
//  UltraDevelopmentServices
//
//  Created by Никита Рассказов on 05.12.2023.
//

import Foundation

enum APIError: LocalizedError {
    case badParameters
    case dataIsNil
    case badStatusCode(Int)
    case error(Error)
    case responseIsNil
    case incorrectlyURL
    case jsonEncodingError

    var errorDescription: String {
        switch self {
        case .badParameters: return "Query parameters are incorrectly"
        case .dataIsNil: return "data is nil"
        case .responseIsNil: return "response is nil"
        case .badStatusCode(let code): return "Bad statuc code: \(code)"
        case .error(let error): return error.localizedDescription
        case .incorrectlyURL: return "Bad url provided"
        case .jsonEncodingError: return "Json Encoding Error"
        }
    }
}
