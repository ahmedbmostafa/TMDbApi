//
//  MovieGridViewModelTests.swift
//  TMDbApiTests
//
//  Created by Ahmed beddah on 29/11/2024.
//

import XCTest
@testable import TMDbApi

class MovieGridViewModelTests: XCTestCase {
    func testMovieGridViewModelInitialization() {
        let movie = MovieDataStub.mockTrendingMovies[0]
        let viewModel = MovieGridViewModel(movie: movie)
        XCTAssertEqual(viewModel.movieID, 1)
        XCTAssertEqual(viewModel.movieTitleValue, "Movie One")
        XCTAssertEqual(viewModel.releaseYearValue, "2024")
        XCTAssertEqual(viewModel.movieImageValue?.absoluteString, "https://image.tmdb.org/t/p/w500/path/to/poster1.jpg")
        XCTAssertEqual(viewModel.posterPlaceholderValue, "poster_placeholder")
    }
}
