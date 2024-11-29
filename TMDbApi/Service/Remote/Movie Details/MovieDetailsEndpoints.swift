//
//  MovieDetailsEndpoints.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 29/11/2024.
//

import Foundation

enum MovieDetailsEndpoints {
    
    // MARK: - Cases
    
    case getMovieDetails(movieID: Int)
    
    // MARK: - Properties
    
    var baseURL: String {
        switch self {
        default:
            return valueOfSecret(named: "BaseURL")
        }
    }
    
    var apiKey: String {
        switch self {
        default:
            return valueOfSecret(named: "ApiKey")
        }
    }
    
    var path: String {
        switch self {
        case .getMovieDetails(let movieID):
            return "/movie/\(movieID)"
        }
    }
    
    var query: String {
        switch self {
        default:
            return "?api_key=\(apiKey)"
        }
    }
    var httpMethod: HttpMethod {
        switch self {
        case .getMovieDetails:
            return .get
        }
    }
    
    // MARK: - Request
    
    func createRequest(parameters: [String: Any]?) -> URLRequest {
        let pathURL = URL(string: self.baseURL + self.path + query)!
        print("pathURL=",pathURL)
        var urlRequest = URLRequest(url: pathURL)
        urlRequest.httpMethod = self.httpMethod.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        if urlRequest.httpMethod != "GET" {
            if let parameters = parameters {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters , options: .fragmentsAllowed)
            }
        }
        return urlRequest
    }
}
