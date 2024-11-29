//
//  TrendingMoviesEndpoints.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 27/11/2024.
//

import Foundation

enum TrendingMoviesEndpoints {
    
    // MARK: - Cases
    
    case getGenres
    case getTrendingMovies(page: Int)
    
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
        case .getGenres:
            return "/genre/movie/list"
        case .getTrendingMovies:
            return "/discover/movie"
        }
    }
    
    var query: String {
        switch self {
        case .getTrendingMovies(let page):
            return "?api_key=\(apiKey)&include_adult=false&sort_by=popularity.desc&page=\(page)"
        default:
            return "?api_key=\(apiKey)"
        }
    }
    var httpMethod: HttpMethod {
        switch self {
        case .getGenres:
            return .get
        case .getTrendingMovies:
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
