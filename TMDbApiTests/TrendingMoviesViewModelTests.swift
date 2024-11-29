//
//  TrendingMoviesViewModelTests.swift
//  TMDbApiTests
//
//  Created by Ahmed beddah on 29/11/2024.
//

import XCTest
@testable import TMDbApi

class TrendingMoviesViewModelTests: XCTestCase {
    
    var viewModel: TrendingMoviesViewModel!
    var mockCacheManager: MockCacheManager!
    var mockService: MockTrendingMoviesService!
    
    override func setUp() {
        super.setUp()
        mockCacheManager = MockCacheManager()
        mockService = MockTrendingMoviesService()
        viewModel = TrendingMoviesViewModel(trendingMoviesService: mockService, cacheManager: mockCacheManager)
    }
    
    func testLoadGenresFromCache() {
        let genres = GenresModel(genres: MovieDataStub.mockGenres)
        mockCacheManager.saveToCache(genres, forKey: "genres")
        viewModel.onAppear()
        XCTAssertEqual(viewModel.genres.count, 3)
        XCTAssertEqual(viewModel.genres.first?.name, "Action")
    }
    
    func testLoadGenresFromAPI() {
        mockService.shouldReturnError = false
        viewModel.onAppear()
        XCTAssertEqual(viewModel.genres.count, 3)
        XCTAssertEqual(viewModel.genres.first?.name, "Action")
    }

    func testLoadTrendingMoviesFromCache() {
        let movies = TrendingMoviesModel(results: MovieDataStub.mockTrendingMovies)
        mockCacheManager.saveToCache(movies, forKey: "trendingMovies")
        viewModel.onAppear()
        XCTAssertEqual(viewModel.trendingMovies.count, 3)
        XCTAssertEqual(viewModel.trendingMovies.first?.title, "Movie One")
    }
    
    func testLoadTrendingMoviesFromAPI() {
        mockService.shouldReturnError = false
        viewModel.onAppear()
        XCTAssertEqual(viewModel.trendingMovies.count, 3)
        XCTAssertEqual(viewModel.trendingMovies.first?.title, "Movie One")
    }

    func testErrorHandlingForAPIFailure() {
        mockService.shouldReturnError = true
        viewModel.onAppear()
        XCTAssertEqual(viewModel.trendingMovies.count, 0)
    }
    
    func testSearchMovies() {
        viewModel.trendingMovies = MovieDataStub.mockTrendingMovies
        viewModel.searchText = "Movie One"
        viewModel.updateFilteredMovies()
        XCTAssertEqual(viewModel.searchResults.count, 1)
        XCTAssertEqual(viewModel.searchResults[0].title, "Movie One")
        viewModel.searchText = "Nonexistent Movie"
        viewModel.updateFilteredMovies()
        XCTAssertEqual(viewModel.searchResults.count, 0)
    }
    
    func testFilterByGenre() {
        viewModel.genres = MovieDataStub.mockGenres
        viewModel.trendingMovies = MovieDataStub.mockTrendingMovies
        viewModel.selectedGenreID = 1
        viewModel.updateFilteredMovies()
        XCTAssertEqual(viewModel.searchResults.count, 1)
        XCTAssertEqual(viewModel.searchResults[0].title, "Movie One")
    }
    
    func testSearchAndFilterByGenre() {
        viewModel.genres = MovieDataStub.mockGenres
        viewModel.trendingMovies = MovieDataStub.mockTrendingMovies
        viewModel.searchText = "Movie One"
        viewModel.selectedGenreID = 1
        viewModel.updateFilteredMovies()
        XCTAssertEqual(viewModel.searchResults.count, 1)
        XCTAssertEqual(viewModel.searchResults[0].title, "Movie One")
    }
}
