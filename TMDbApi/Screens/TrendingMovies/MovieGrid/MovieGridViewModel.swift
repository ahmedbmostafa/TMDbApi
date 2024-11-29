//
//  MovieGridViewModel.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 29/11/2024.
//

import Foundation

class MovieGridViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var movie: TrendingMovieModel
    
    init(movie: TrendingMovieModel) {
        self.movie = movie
    }
    
    var movieID: Int {
        movie.id
    }
    
    var movieTitleValue: String {
        movie.title
    }
    
    var releaseYearValue: String {
        movie.releaseDate.releaseYear
    }
    
    var movieImageValue: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
    }
    
    var posterPlaceholderValue: String {
        "poster_placeholder"
    }
}
