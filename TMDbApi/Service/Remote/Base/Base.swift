//
//  Base.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 27/11/2024.
//

import Foundation

var baseURL: String {
    valueOfSecret(named: "BaseURL")
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidURL
    case requestFailed(String)
    case decodingFailed
    case tokenExpired
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The URL provided was invalid.", comment: "")
        case .requestFailed(let message):
            return NSLocalizedString(message, comment: "")
        case .decodingFailed:
            return NSLocalizedString("decoding Failed", comment: "")
        case .tokenExpired:
            return NSLocalizedString("The token has expired. Please log in again.", comment: "")
        }
    }
}

struct ErrorResponseModel: Decodable {
    let message: String
    let data: String?
}
