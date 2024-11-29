//
//  MovieDetailsViewModelTests.swift
//  TMDbApiTests
//
//  Created by Ahmed beddah on 29/11/2024.
//

import XCTest
@testable import TMDbApi

class MovieDetailsViewModelTests: XCTestCase {
    
    var viewModel: MovieDetailsViewModel!
    var mockCacheManager: MockCacheManager!
    var mockService: MockMovieDetailsService!
    
    override func setUp() {
        super.setUp()
        mockCacheManager = MockCacheManager()
        mockService = MockMovieDetailsService()
        viewModel = MovieDetailsViewModel(movieID: 1, movieDetailsService: mockService, cacheManager: mockCacheManager)
    }
    
    func testLoadMovieDetailsFromCache() {
        let movieDetails = MovieDataStub.mockMovieDetails
        mockCacheManager.saveMovieDetailsToCache(movieDetails, forMovieID: 1)
        viewModel.onAppear()
        XCTAssertEqual(viewModel.movieDetails?.title, "Movie One")
    }
    
    func testLoadMovieDetailsFromAPI() {
        mockService.shouldReturnError = false
        viewModel.onAppear()
        XCTAssertEqual(viewModel.movieDetails?.title, "Movie One")
    }
}
