//
//  CacheManager.swift
//  TMDbApi
//
//  Created by Ahmed beddah on 29/11/2024.
//

import Foundation

class CacheManager {
    private let memoryCache = NSCache<NSString, NSData>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    init() {
        cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }

    // Save generic data to cache
    func saveToCache<T: Encodable>(_ data: T, forKey key: String) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            memoryCache.setObject(encodedData as NSData, forKey: key as NSString)
            saveToDisk(encodedData, forKey: key)
        } catch {
            print("Failed to encode and cache data for key \(key):", error)
        }
    }

    // Load generic data from cache
    func loadFromCache<T: Decodable>(forKey key: String, as type: T.Type) -> T? {
        if let memoryData = memoryCache.object(forKey: key as NSString) {
            return decode(memoryData as Data, as: type)
        }
        if let diskData = loadFromDisk(forKey: key) {
            let decodedData: T? = decode(diskData, as: type)
            if let _ = decodedData {
                memoryCache.setObject(diskData as NSData, forKey: key as NSString) // Repopulate memory cache
            }
            return decodedData
        }
        return nil
    }

    // Save movie details to cache
    func saveMovieDetailsToCache(_ movieDetails: MovieDetailsModel, forMovieID movieID: Int) {
        let cacheKey = "movieDetails_\(movieID)"
        saveToCache(movieDetails, forKey: cacheKey)
    }

    // Load movie details from cache
    func loadMovieDetailsFromCache(forMovieID movieID: Int) -> MovieDetailsModel? {
        let cacheKey = "movieDetails_\(movieID)"
        return loadFromCache(forKey: cacheKey, as: MovieDetailsModel.self)
    }

    // Save to disk
    private func saveToDisk(_ data: Data, forKey key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        do {
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Failed to save data to disk for key \(key):", error)
        }
    }

    // Load from disk
    private func loadFromDisk(forKey key: String) -> Data? {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        return try? Data(contentsOf: fileURL)
    }

    // Decode data into the expected model type
    private func decode<T: Decodable>(_ data: Data, as type: T.Type) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
