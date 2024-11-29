//
//  MovieDataStub.swift
//  TMDbApiTests
//
//  Created by Ahmed beddah on 29/11/2024.
//

import Foundation
@testable import TMDbApi

struct MovieDataStub {
    static let mockGenres: [GenreModel] = [
        GenreModel(id: 1, name: "Action"),
        GenreModel(id: 2, name: "Comedy"),
        GenreModel(id: 3, name: "Drama")
    ]
    
    static let mockTrendingMovies: [TrendingMovieModel] = [
        TrendingMovieModel(id: 1, genreIDS: [1, 2], releaseDate: "2024-05-05", title: "Movie One", posterPath: "/path/to/poster1.jpg"),
        TrendingMovieModel(id: 2, genreIDS: [2], releaseDate: "2024-05-05", title: "Movie Two", posterPath: "/path/to/poster2.jpg"),
        TrendingMovieModel(id: 3, genreIDS: [3], releaseDate: "2024-05-05", title: "Movie Three", posterPath: "/path/to/poster3.jpg")
    ]
    
    static let mockMovieDetails: MovieDetailsModel = MovieDetailsModel(
        backdropPath: "/path/to/backdrop.jpg",
        budget: 100000000,
        genres: [GenreModel(id: 1, name: "Action")],
        homepage: "https://movieone.com",
        id: 1 ,
        overview: "An action-packed thriller.",
        posterPath: "/path/to/poster1.jpg",
        releaseDate: "2024-05-05",
        revenue: 200000000,
        runtime: 160,
        spokenLanguages: [SpokenLanguage(name: "English")],
        status: "Released",
        title: "Movie One"
    )
}
