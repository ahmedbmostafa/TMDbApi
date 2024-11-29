//
//  NetworkService.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 27/11/2024.
//

import Foundation
import Combine

protocol NetworkService {
    func request<T: Decodable>(_ urlRequest: URLRequest, decodingType: T.Type) -> AnyPublisher<T, APIError>
}

class NetworkManager: ObservableObject, NetworkService {
    
    private let session: NetworkSession
    private var baseURL: String!
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ urlRequest: URLRequest, decodingType: T.Type) -> AnyPublisher<T, APIError> {
        return self.session.publisher(urlRequest, decodingType: decodingType)
            .mapError({ error -> APIError in
                return error
            })
            .eraseToAnyPublisher()
    }
}
