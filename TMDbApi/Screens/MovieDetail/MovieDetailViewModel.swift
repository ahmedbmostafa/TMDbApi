//
//  MovieDetailViewModel.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 29/11/2024.
//

import Foundation
import Combine

class MovieDetailsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var movieDetails: MovieDetailsModel?
    @Published var movieID: Int
    private let movieDetailsService: MovieDetailsServiceable
    private var cancellables = Set<AnyCancellable>()
    
    init(movieID: Int, movieDetailsService: MovieDetailsServiceable = MovieDetailsService()) {
        self.movieID = movieID
        self.movieDetailsService = movieDetailsService
        getMovieDetails()
    }
}

// MARK: - MovieDetails

extension MovieDetailsViewModel {
    private func getMovieDetails() {
        let response: AnyPublisher<MovieDetailsModel, APIError> = movieDetailsService.getMovieDetails(movieID: movieID)
        response
            .sink(receiveCompletion: onReceiveFailure, receiveValue: onReceiveMovieDetailsModelResponse)
            .store(in: &cancellables)
    }
    
    private func onReceiveFailure(_ completion: Subscribers.Completion<APIError>) {
        if case let .failure(error) = completion {
            print("err=",error)
        }
    }
    
    private func onReceiveMovieDetailsModelResponse(_ response: MovieDetailsModel) {
        movieDetails = response
        print("movieDetails", movieDetails?.title ?? "")
    }
}

extension MovieDetailsViewModel {
    var movieTitleValue: String {
        (movieDetails?.title ?? "") + "(\(releaseDateValue)"
    }
    
    var movieBackImageValue: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails?.backdropPath ?? "")")
    }
    
    var movieImageValue: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails?.posterPath ?? "")")
    }
    
    var releaseDateValue: String {
        (movieDetails?.releaseDate ?? "").releaseYearAndMonth
    }
    
    var movieGenresValue: String {
        let genreNames = movieDetails?.genres.map { $0.name }
        return genreNames?.joined(separator: ", ") ?? ""
    }
    
    var overviewValue: String {
        movieDetails?.overview ?? ""
    }
    
    var homepageValue: URL? {
        URL(string: movieDetails?.homepage ?? "astek.com")
    }
    
    var budgetValue: String {
        "\(movieDetails?.budget ?? 0) " + "$"
    }
    
    var revenueValue: String {
        "\(movieDetails?.revenue ?? 0) " + "$" 
    }
    
    var spokenLanguagesValue: String {
        let languageNames = movieDetails?.spokenLanguages.map { $0.name }
        return languageNames?.joined(separator: ", ") ?? ""
    }
    
    var statusValue: String {
        movieDetails?.status ?? ""
    }
    
    var runTimeValue: Int {
        movieDetails?.runtime ?? 0
    }
    
    var posterPlaceholderValue: String {
        "poster_placeholder"
    }
}
