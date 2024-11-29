//
//  NetworkSession.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 27/11/2024.
//

import Foundation
import Combine

protocol NetworkSession: AnyObject {
    func publisher<T: Decodable>(_ request: URLRequest, decodingType: T.Type) -> AnyPublisher<T, APIError>
}

extension URLSession: NetworkSession {
    func publisher<T: Decodable>(_ request: URLRequest, decodingType: T.Type) -> AnyPublisher<T, APIError> {
        return dataTaskPublisher(for: request)
            .tryMap({ result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw APIError.requestFailed("error")
                }
                if (200..<300) ~= httpResponse.statusCode {
                    return result.data
                } else if httpResponse.statusCode == 401 {
                    throw APIError.tokenExpired
                } else {
                    let errorResponse = try JSONDecoder().decode(ErrorResponseModel.self, from: result.data)
                    throw APIError.requestFailed(errorResponse.message)
                }
            })
            .receive(on: RunLoop.main)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ error -> APIError in
                debugPrint("error=", error)
                if let error = error as? APIError {
                    return error
                }
                return APIError.decodingFailed
            })
            .eraseToAnyPublisher()
    }
}
