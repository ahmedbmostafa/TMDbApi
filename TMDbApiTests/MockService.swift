//
//  MockService.swift
//  TMDbApiTests
//
//  Created by Ahmed beddah on 29/11/2024.
//

import Combine
@testable import TMDbApi

class MockTrendingMoviesService: TrendingMoviesServiceable {
    var shouldReturnError = false
    
    func getGenres() -> AnyPublisher<GenresModel, APIError> {
        if shouldReturnError {
            return Fail(error: APIError.requestFailed("Please try again later"))
                .eraseToAnyPublisher()
        }
        let genres = GenresModel(genres: MovieDataStub.mockGenres)
        return Just(genres).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }
    
    func getTrendingMovies(page: Int) -> AnyPublisher<TrendingMoviesModel, APIError> {
        if shouldReturnError {
            return Fail(error: APIError.requestFailed("Please try again later"))
                .eraseToAnyPublisher()
        }
        let movies = TrendingMoviesModel(results: MovieDataStub.mockTrendingMovies)
        return Just(movies).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }
}

class MockMovieDetailsService: MovieDetailsServiceable {
    var shouldReturnError = false
    
    func getMovieDetails(movieID: Int) -> AnyPublisher<MovieDetailsModel, APIError> {
        if shouldReturnError {
            return Fail(error: APIError.requestFailed("Please try again later"))
                .eraseToAnyPublisher()
        }
        let movieDetails = MovieDataStub.mockMovieDetails
        return Just(movieDetails).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }
}
