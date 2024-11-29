//
//  TrendingMoviesService.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 27/11/2024.
//

import Foundation
import Combine

protocol TrendingMoviesServiceable {
    func getGenres() -> AnyPublisher<GenresModel, APIError>
    func getTrendingMovies(page: Int) -> AnyPublisher<TrendingMoviesModel, APIError>
}

class TrendingMoviesService: TrendingMoviesServiceable {
    
    // MARK: - Properties
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    func getGenres() -> AnyPublisher<GenresModel, APIError> {
        let endpoint = TrendingMoviesEndpoints.getGenres
        let request = endpoint.createRequest(parameters: nil)
        return networkService.request(request, decodingType: GenresModel.self)
    }
    
    func getTrendingMovies(page: Int) -> AnyPublisher<TrendingMoviesModel, APIError> {
        let endpoint = TrendingMoviesEndpoints.getTrendingMovies(page: page)
        let request = endpoint.createRequest(parameters: nil)
        return networkService.request(request, decodingType: TrendingMoviesModel.self)
    }
}
