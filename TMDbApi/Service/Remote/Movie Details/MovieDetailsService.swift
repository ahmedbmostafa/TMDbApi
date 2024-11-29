//
//  MovieDetailsService.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 29/11/2024.
//

import Foundation
import Combine

protocol MovieDetailsServiceable {
    func getMovieDetails(movieID: Int) -> AnyPublisher<MovieDetailsModel, APIError>
}

class MovieDetailsService: MovieDetailsServiceable {
    
    // MARK: - Properties
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    func getMovieDetails(movieID: Int) -> AnyPublisher<MovieDetailsModel, APIError> {
        let endpoint = MovieDetailsEndpoints.getMovieDetails(movieID: movieID)
        let request = endpoint.createRequest(parameters: nil)
        return networkService.request(request, decodingType: MovieDetailsModel.self)
    }
}
