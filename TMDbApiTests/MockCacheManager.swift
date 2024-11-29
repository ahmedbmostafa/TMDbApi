//
//  MockCacheManager.swift
//  TMDbApiTests
//
//  Created by Ahmed beddah on 29/11/2024.
//

import Foundation
@testable import TMDbApi

class MockCacheManager: CacheManager {
    var mockCache = [String: Any]()
    
    override func saveToCache<T: Encodable>(_ data: T, forKey key: String) {
        mockCache[key] = data
    }
    
    override func loadFromCache<T: Decodable>(forKey key: String, as type: T.Type) -> T? {
        return mockCache[key] as? T
    }
    
    override func loadMovieDetailsFromCache(forMovieID movieID: Int) -> MovieDetailsModel? {
        return mockCache["movieDetails_\(movieID)"] as? MovieDetailsModel
    }
    
    override func saveMovieDetailsToCache(_ data: MovieDetailsModel, forMovieID movieID: Int) {
        mockCache["movieDetails_\(movieID)"] = data
    }
}
